// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/material.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'package:provider/provider.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_colors.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_radius.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_spacing.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/utils/currency_formatter.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../providers/insight_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/empty_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/error_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/section_title.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/statistics/local_bar_chart.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/statistics/stat_card.dart';

/// Displays local statistics from SQLite with cards and a fl_chart bar chart.
// Mendefinisikan class utama untuk bagian fitur ini.
class InsightStatisticsScreen extends StatefulWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const InsightStatisticsScreen({super.key});

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  State<InsightStatisticsScreen> createState() => _InsightStatisticsScreenState();
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _InsightStatisticsScreenState extends State<InsightStatisticsScreen> {
  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void initState() {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.initState();
    // Load after first frame so Provider access is safe from initState.
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Menghubungkan UI dengan state Provider yang ringan.
        context.read<InsightProvider>().loadInsights();
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    });
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  int _count(Map<String, int> summary, String key) => summary[key] ?? 0;

  // Maps SQLite count keys into chart items shown by LocalBarChart.
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  List<LocalChartItem> _chartItems(Map<String, int> summary) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return [
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LocalChartItem(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        label: 'Total Produk',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        shortLabel: 'Produk',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        value: _count(summary, 'products'),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LocalChartItem(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        label: 'Total Kategori',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        shortLabel: 'Kategori',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        value: _count(summary, 'categories'),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LocalChartItem(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        label: 'Item Keranjang',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        shortLabel: 'Cart',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        value: _count(summary, 'cart_items'),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LocalChartItem(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        label: 'Wishlist',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        shortLabel: 'Wish',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        value: _count(summary, 'wishlist_items'),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LocalChartItem(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        label: 'Simulasi Order',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        shortLabel: 'Order',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        value: _count(summary, 'orders'),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LocalChartItem(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        label: 'Catatan Produk',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        shortLabel: 'Note',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        value: _count(summary, 'product_notes'),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    ];
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menghubungkan UI dengan state Provider yang ringan.
  List<_StatItem> _statItems(InsightProvider provider) {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final summary = provider.countSummary;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return [
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _StatItem('Total Produk', '${_count(summary, 'products')}', 'Data katalog lokal'),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _StatItem('Total Kategori', '${_count(summary, 'categories')}', 'Grouping produk'),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _StatItem('Item Keranjang', '${_count(summary, 'cart_items')}', 'Cart SQLite lokal'),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _StatItem('Wishlist', '${_count(summary, 'wishlist_items')}', 'Favorit lokal'),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _StatItem('Simulasi Order', '${_count(summary, 'orders')}', 'Order simulasi lokal'),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _StatItem('Catatan Produk', '${_count(summary, 'product_notes')}', 'Note produk lokal'),
    // Menutup blok kode agar struktur Dart tetap valid.
    ];
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return Scaffold(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      appBar: AppBar(title: const Text('Insight Lokal')),
      // Menghubungkan UI dengan state Provider yang ringan.
      body: Consumer<InsightProvider>(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        builder: (context, provider, _) {
          // Memeriksa kondisi agar alur aplikasi tetap aman.
          if (provider.isLoading) {
            // Mengembalikan hasil yang dibutuhkan pemanggil kode.
            return const Center(child: CircularProgressIndicator());
          // Menutup blok kode agar struktur Dart tetap valid.
          }

          // Memeriksa kondisi agar alur aplikasi tetap aman.
          if (provider.errorMessage != null) {
            // Mengembalikan hasil yang dibutuhkan pemanggil kode.
            return ErrorState(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              title: provider.errorMessage!,
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              onAction: provider.loadInsights,
            // Menutup blok kode agar struktur Dart tetap valid.
            );
          // Menutup blok kode agar struktur Dart tetap valid.
          }

          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          final stats = _statItems(provider);
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          final chartItems = _chartItems(provider.countSummary);

          // Mengembalikan hasil yang dibutuhkan pemanggil kode.
          return RefreshIndicator(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            onRefresh: provider.loadInsights,
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            child: ListView(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              padding: const EdgeInsets.all(AppSpacing.md),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              children: [
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SectionTitle(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  title: 'Insight Statistik Lokal',
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  subtitle: 'Data lokal dari perangkat. Bukan analytics online dan tidak ada tracking user.',
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.lg),
                // Memeriksa kondisi agar alur aplikasi tetap aman.
                if (provider.isAllEmpty) ...[
                  // Menyimpan nilai yang dipakai oleh alur fitur ini.
                  const EmptyState(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    title: 'Belum ada statistik lokal.',
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    description: 'Tambahkan produk, cart, wishlist, order, atau catatan untuk melihat insight.',
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                  // Menyimpan nilai yang dipakai oleh alur fitur ini.
                  const SizedBox(height: AppSpacing.lg),
                // Menutup blok kode agar struktur Dart tetap valid.
                ],
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                GridView.builder(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  shrinkWrap: true,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  physics: const NeverScrollableScrollPhysics(),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  itemCount: stats.length,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    crossAxisCount: 2,
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    crossAxisSpacing: AppSpacing.sm,
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    mainAxisSpacing: AppSpacing.sm,
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    childAspectRatio: 1.35,
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  itemBuilder: (context, index) {
                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                    final stat = stats[index];
                    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                    return StatCard(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      title: stat.title,
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      value: stat.value,
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      subtitle: stat.subtitle,
                    // Menutup blok kode agar struktur Dart tetap valid.
                    );
                  // Menutup blok kode agar struktur Dart tetap valid.
                  },
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.lg),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                _MoneySummary(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  cartEstimatedTotal: provider.cartEstimatedTotal,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  totalOrderAmount: provider.totalOrderAmount,
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.lg),
                // Chart uses aggregated local counts only; no online analytics are sent.
                // Menyiapkan visual statistik lokal menggunakan fl_chart.
                LocalBarChart(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  items: chartItems,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  emptyLabel: 'Belum ada data untuk divisualkan dari SQLite lokal.',
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
              // Menutup blok kode agar struktur Dart tetap valid.
              ],
            // Menutup blok kode agar struktur Dart tetap valid.
            ),
          // Menutup blok kode agar struktur Dart tetap valid.
          );
        // Menutup blok kode agar struktur Dart tetap valid.
        },
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _MoneySummary extends StatelessWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const _MoneySummary({
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.cartEstimatedTotal,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.totalOrderAmount,
  // Menutup blok kode agar struktur Dart tetap valid.
  });

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final double cartEstimatedTotal;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final double totalOrderAmount;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return Container(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      padding: const EdgeInsets.all(AppSpacing.md),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      decoration: BoxDecoration(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        color: AppColors.surfaceContainerLow,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        borderRadius: BorderRadius.circular(AppRadius.lg),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        border: Border.all(color: AppColors.border),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      child: Column(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        children: [
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          Text('Ringkasan Nilai Lokal', style: Theme.of(context).textTheme.titleLarge),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.sm),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          _MoneyRow(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            label: 'Estimasi Keranjang',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            value: CurrencyFormatter.formatRupiah(cartEstimatedTotal.round()),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.xs),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          _MoneyRow(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            label: 'Total Nilai Simulasi Order',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            value: CurrencyFormatter.formatRupiah(totalOrderAmount.round()),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.sm),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const Text(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            'Angka ini dihitung dari SQLite lokal, bukan analytics online.',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
        // Menutup blok kode agar struktur Dart tetap valid.
        ],
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _MoneyRow extends StatelessWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const _MoneyRow({required this.label, required this.value});

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String label;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String value;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return Row(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      children: [
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        Expanded(child: Text(label)),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
      // Menutup blok kode agar struktur Dart tetap valid.
      ],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _StatItem {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const _StatItem(this.title, this.value, this.subtitle);

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String title;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String value;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String subtitle;
// Menutup blok kode agar struktur Dart tetap valid.
}
