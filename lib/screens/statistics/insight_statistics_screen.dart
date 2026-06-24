import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/currency_formatter.dart';
import '../../providers/insight_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/section_title.dart';
import '../../widgets/statistics/local_bar_chart.dart';
import '../../widgets/statistics/stat_card.dart';

class InsightStatisticsScreen extends StatefulWidget {
  const InsightStatisticsScreen({super.key});

  @override
  State<InsightStatisticsScreen> createState() => _InsightStatisticsScreenState();
}

class _InsightStatisticsScreenState extends State<InsightStatisticsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<InsightProvider>().loadInsights();
      }
    });
  }

  int _count(Map<String, int> summary, String key) => summary[key] ?? 0;

  List<LocalChartItem> _chartItems(Map<String, int> summary) {
    return [
      LocalChartItem(
        label: 'Total Produk',
        shortLabel: 'Produk',
        value: _count(summary, 'products'),
      ),
      LocalChartItem(
        label: 'Total Kategori',
        shortLabel: 'Kategori',
        value: _count(summary, 'categories'),
      ),
      LocalChartItem(
        label: 'Item Keranjang',
        shortLabel: 'Cart',
        value: _count(summary, 'cart_items'),
      ),
      LocalChartItem(
        label: 'Wishlist',
        shortLabel: 'Wish',
        value: _count(summary, 'wishlist_items'),
      ),
      LocalChartItem(
        label: 'Simulasi Order',
        shortLabel: 'Order',
        value: _count(summary, 'orders'),
      ),
      LocalChartItem(
        label: 'Catatan Produk',
        shortLabel: 'Note',
        value: _count(summary, 'product_notes'),
      ),
    ];
  }

  List<_StatItem> _statItems(InsightProvider provider) {
    final summary = provider.countSummary;
    return [
      _StatItem('Total Produk', '${_count(summary, 'products')}', 'Data katalog lokal'),
      _StatItem('Total Kategori', '${_count(summary, 'categories')}', 'Grouping produk'),
      _StatItem('Item Keranjang', '${_count(summary, 'cart_items')}', 'Cart SQLite lokal'),
      _StatItem('Wishlist', '${_count(summary, 'wishlist_items')}', 'Favorit lokal'),
      _StatItem('Simulasi Order', '${_count(summary, 'orders')}', 'Order simulasi lokal'),
      _StatItem('Catatan Produk', '${_count(summary, 'product_notes')}', 'Note produk lokal'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insight Lokal')),
      body: Consumer<InsightProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return ErrorState(
              title: provider.errorMessage!,
              onAction: provider.loadInsights,
            );
          }

          final stats = _statItems(provider);
          final chartItems = _chartItems(provider.countSummary);

          return RefreshIndicator(
            onRefresh: provider.loadInsights,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                const SectionTitle(
                  title: 'Insight Statistik Lokal',
                  subtitle: 'Data lokal dari perangkat. Bukan analytics online dan tidak ada tracking user.',
                ),
                const SizedBox(height: AppSpacing.lg),
                if (provider.isAllEmpty) ...[
                  const EmptyState(
                    title: 'Belum ada statistik lokal.',
                    description: 'Tambahkan produk, cart, wishlist, order, atau catatan untuk melihat insight.',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stats.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.sm,
                    mainAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 1.35,
                  ),
                  itemBuilder: (context, index) {
                    final stat = stats[index];
                    return StatCard(
                      title: stat.title,
                      value: stat.value,
                      subtitle: stat.subtitle,
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                _MoneySummary(
                  cartEstimatedTotal: provider.cartEstimatedTotal,
                  totalOrderAmount: provider.totalOrderAmount,
                ),
                const SizedBox(height: AppSpacing.lg),
                LocalBarChart(
                  items: chartItems,
                  emptyLabel: 'Belum ada data untuk divisualkan dari SQLite lokal.',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MoneySummary extends StatelessWidget {
  const _MoneySummary({
    required this.cartEstimatedTotal,
    required this.totalOrderAmount,
  });

  final double cartEstimatedTotal;
  final double totalOrderAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ringkasan Nilai Lokal', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          _MoneyRow(
            label: 'Estimasi Keranjang',
            value: CurrencyFormatter.formatRupiah(cartEstimatedTotal.round()),
          ),
          const SizedBox(height: AppSpacing.xs),
          _MoneyRow(
            label: 'Total Nilai Simulasi Order',
            value: CurrencyFormatter.formatRupiah(totalOrderAmount.round()),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Angka ini dihitung dari SQLite lokal, bukan analytics online.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _MoneyRow extends StatelessWidget {
  const _MoneyRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
      ],
    );
  }
}

class _StatItem {
  const _StatItem(this.title, this.value, this.subtitle);

  final String title;
  final String value;
  final String subtitle;
}
