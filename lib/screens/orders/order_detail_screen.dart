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
import '../../providers/order_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/empty_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/error_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/orders/order_status_stepper.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/section_title.dart';

/// Shows local order detail and lets the demo update simulation status safely.
// Mendefinisikan class utama untuk bagian fitur ini.
class OrderDetailScreen extends StatefulWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const OrderDetailScreen({super.key, required this.orderId});

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final int orderId;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _OrderDetailScreenState extends State<OrderDetailScreen> {
  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void initState() {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.initState();
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Menghubungkan UI dengan state Provider yang ringan.
        context.read<OrderProvider>().loadOrderDetail(widget.orderId);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    });
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  String _formatDate(String value) {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final date = DateTime.tryParse(value);
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (date == null) return value;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return '${date.day.toString().padLeft(2, '0')}/'
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  String _statusLabel(String status) {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    switch (status) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      case 'dibuat':
        // Mengembalikan hasil yang dibutuhkan pemanggil kode.
        return 'Dibuat';
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      case 'diproses':
        // Mengembalikan hasil yang dibutuhkan pemanggil kode.
        return 'Diproses';
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      case 'selesai':
        // Mengembalikan hasil yang dibutuhkan pemanggil kode.
        return 'Selesai';
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      case 'dibatalkan':
        // Mengembalikan hasil yang dibutuhkan pemanggil kode.
        return 'Dibatalkan';
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      default:
        // Mengembalikan hasil yang dibutuhkan pemanggil kode.
        return status;
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Status updates are local-only; no payment, shipping, or delivery tracking is involved.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _updateStatus(String status) async {
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menghubungkan UI dengan state Provider yang ringan.
      await context.read<OrderProvider>().updateOrderStatus(widget.orderId, status);
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SnackBar(content: Text('Status simulasi: ${_statusLabel(status)}.')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(SnackBar(content: Text('Gagal update status: $e')));
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _deleteOrder() async {
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menghubungkan UI dengan state Provider yang ringan.
      await context.read<OrderProvider>().deleteOrder(widget.orderId);
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SnackBar(content: Text('Simulasi order lokal dihapus.')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
      // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
      Navigator.of(context).pop();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(SnackBar(content: Text('Gagal hapus order: $e')));
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return Scaffold(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      appBar: AppBar(title: const Text('Detail Simulasi Order')),
      // Menghubungkan UI dengan state Provider yang ringan.
      body: Consumer<OrderProvider>(
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
              onAction: () => provider.loadOrderDetail(widget.orderId),
            // Menutup blok kode agar struktur Dart tetap valid.
            );
          // Menutup blok kode agar struktur Dart tetap valid.
          }

          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          final order = provider.selectedOrder;
          // Memeriksa kondisi agar alur aplikasi tetap aman.
          if (order == null) {
            // Mengembalikan hasil yang dibutuhkan pemanggil kode.
            return const EmptyState(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              title: 'Simulasi order tidak ditemukan.',
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              description: 'Data lokal mungkin sudah dihapus.',
            // Menutup blok kode agar struktur Dart tetap valid.
            );
          // Menutup blok kode agar struktur Dart tetap valid.
          }

          // Mengembalikan hasil yang dibutuhkan pemanggil kode.
          return ListView(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            padding: const EdgeInsets.all(AppSpacing.md),
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            children: [
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              SectionTitle(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                title: order.orderCode,
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                subtitle: 'Data tersimpan di perangkat • ${_formatDate(order.createdAt)}',
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.md),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              Container(
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
                child: const Text(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  'Simulasi Order Lokal — tidak ada pembayaran real, alamat, atau pengiriman.',
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  style: TextStyle(color: AppColors.textSecondary),
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.lg),
              // CustomPainter stepper doubles as the gesture control for status changes.
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              OrderStatusStepper(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                currentStatus: order.status,
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                onStatusTap: _updateStatus,
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.lg),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              Text('Item Lokal', style: Theme.of(context).textTheme.titleLarge),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.sm),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              ...provider.selectedOrderItems.map(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                (item) => Container(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  padding: const EdgeInsets.all(AppSpacing.md),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  decoration: BoxDecoration(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    color: AppColors.surface,
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    border: Border.all(color: AppColors.border),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  child: Row(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    children: [
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      Expanded(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        child: Text(
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          item.productNameSnapshot,
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        // Menutup blok kode agar struktur Dart tetap valid.
                        ),
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      Text('${item.quantity}x'),
                      // Menyimpan nilai yang dipakai oleh alur fitur ini.
                      const SizedBox(width: AppSpacing.md),
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      Text(CurrencyFormatter.formatRupiah(item.subtotal.round())),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ],
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.md),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              Container(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                padding: const EdgeInsets.all(AppSpacing.md),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                decoration: BoxDecoration(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  color: AppColors.primary,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                child: Row(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  children: [
                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                    const Expanded(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      child: Text(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        'Total Simulasi',
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        style: TextStyle(
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          color: AppColors.onPrimary,
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          fontWeight: FontWeight.w700,
                        // Menutup blok kode agar struktur Dart tetap valid.
                        ),
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    Text(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      CurrencyFormatter.formatRupiah(order.totalAmount.round()),
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      style: const TextStyle(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        color: AppColors.onPrimary,
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        fontWeight: FontWeight.w800,
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ],
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.md),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              TextButton.icon(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                onPressed: _deleteOrder,
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                icon: const Icon(Icons.delete_outline),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                label: const Text('Hapus Simulasi Order Lokal'),
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
            // Menutup blok kode agar struktur Dart tetap valid.
            ],
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
