import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/currency_formatter.dart';
import '../../providers/order_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/orders/order_status_stepper.dart';
import '../../widgets/section_title.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final int orderId;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<OrderProvider>().loadOrderDetail(widget.orderId);
      }
    });
  }

  String _formatDate(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
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

  Future<void> _updateStatus(String status) async {
    try {
      await context.read<OrderProvider>().updateOrderStatus(widget.orderId, status);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Status simulasi: ${_statusLabel(status)}.')),
        );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text('Gagal update status: $e')));
    }
  }

  Future<void> _deleteOrder() async {
    try {
      await context.read<OrderProvider>().deleteOrder(widget.orderId);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Simulasi order lokal dihapus.')),
        );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text('Gagal hapus order: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Simulasi Order')),
      body: Consumer<OrderProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return ErrorState(
              title: provider.errorMessage!,
              onAction: () => provider.loadOrderDetail(widget.orderId),
            );
          }

          final order = provider.selectedOrder;
          if (order == null) {
            return const EmptyState(
              title: 'Simulasi order tidak ditemukan.',
              description: 'Data lokal mungkin sudah dihapus.',
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              SectionTitle(
                title: order.orderCode,
                subtitle: 'Data tersimpan di perangkat • ${_formatDate(order.createdAt)}',
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Text(
                  'Simulasi Order Lokal — tidak ada pembayaran real, alamat, atau pengiriman.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              OrderStatusStepper(
                currentStatus: order.status,
                onStatusTap: _updateStatus,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Item Lokal', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              ...provider.selectedOrderItems.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.productNameSnapshot,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text('${item.quantity}x'),
                      const SizedBox(width: AppSpacing.md),
                      Text(CurrencyFormatter.formatRupiah(item.subtotal.round())),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Total Simulasi',
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      CurrencyFormatter.formatRupiah(order.totalAmount.round()),
                      style: const TextStyle(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton.icon(
                onPressed: _deleteOrder,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Hapus Simulasi Order Lokal'),
              ),
            ],
          );
        },
      ),
    );
  }
}
