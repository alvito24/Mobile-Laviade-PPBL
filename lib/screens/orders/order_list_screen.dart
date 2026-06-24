import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../providers/order_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/orders/order_simulation_tile.dart';
import '../../widgets/section_title.dart';
import 'order_detail_screen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<OrderProvider>().loadOrders();
      }
    });
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'dibuat':
        return 'Dibuat';
      case 'diproses':
        return 'Diproses';
      case 'selesai':
        return 'Selesai';
      case 'dibatalkan':
        return 'Dibatalkan';
      default:
        return status;
    }
  }

  String _formatDate(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulasi Order Lokal')),
      body: Consumer<OrderProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return ErrorState(
              title: provider.errorMessage!,
              onAction: provider.loadOrders,
            );
          }

          final orders = provider.orders;

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              const SectionTitle(
                title: 'Simulasi Order Lokal',
                subtitle: 'Data tersimpan di perangkat. Tidak ada pembayaran real.',
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Status simulasi bisa diperbarui lokal: Dibuat, Diproses, Selesai, atau Dibatalkan.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (orders.isEmpty)
                const EmptyState(
                  title: 'Belum ada simulasi order.',
                  description: 'Buat Simulasi Order Lokal dari Cart untuk melihat riwayat lokal.',
                )
              else
                ...orders.map(
                  (order) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: OrderSimulationTile(
                      orderCode: order.orderCode,
                      status: _statusLabel(order.status),
                      createdAt: _formatDate(order.createdAt),
                      itemCount: order.totalItems,
                      totalAmount: order.totalAmount,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => OrderDetailScreen(orderId: order.id!),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
