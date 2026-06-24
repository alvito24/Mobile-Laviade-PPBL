// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/material.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'package:provider/provider.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_spacing.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../providers/wishlist_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/empty_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/error_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/section_title.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/wishlist/wishlist_item_tile.dart';

/// Reads wishlist products from SQLite through WishlistProvider.
// Mendefinisikan class utama untuk bagian fitur ini.
class WishlistScreen extends StatefulWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const WishlistScreen({super.key});

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  State<WishlistScreen> createState() => _WishlistScreenState();
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _WishlistScreenState extends State<WishlistScreen> {
  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void initState() {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.initState();
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load after first frame because Provider depends on a ready BuildContext.
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Menghubungkan UI dengan state Provider yang ringan.
        context.read<WishlistProvider>().loadWishlist();
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    });
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Remove only the wishlist relation, not the product itself.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _removeWishlist(int productId, String productName) async {
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menghubungkan UI dengan state Provider yang ringan.
      await context.read<WishlistProvider>().removeWishlist(productId);
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SnackBar(content: Text('$productName dihapus dari wishlist lokal.')),
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
        ..showSnackBar(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SnackBar(content: Text('Gagal menghapus wishlist: $e')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
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
      appBar: AppBar(title: const Text('Wishlist')),
      // Menghubungkan UI dengan state Provider yang ringan.
      body: Consumer<WishlistProvider>(
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
              onAction: provider.loadWishlist,
            // Menutup blok kode agar struktur Dart tetap valid.
            );
          // Menutup blok kode agar struktur Dart tetap valid.
          }

          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          final items = provider.wishlistProducts;

          // Mengembalikan hasil yang dibutuhkan pemanggil kode.
          return ListView(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            padding: const EdgeInsets.all(AppSpacing.md),
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            children: [
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SectionTitle(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                title: 'Wishlist Lokal',
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                subtitle: 'Produk favorit tersimpan di SQLite pada perangkat ini.',
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.lg),
              // Memeriksa kondisi agar alur aplikasi tetap aman.
              if (items.isEmpty)
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const EmptyState(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  title: 'Wishlist masih kosong.',
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  description: 'Simpan produk dari Product Detail untuk mengisi wishlist lokal.',
                // Menutup blok kode agar struktur Dart tetap valid.
                )
              // Menangani kondisi alternatif dari percabangan sebelumnya.
              else
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                ...items.map(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  (item) {
                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                    final productId = item['product_id'] as int;
                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                    final productName = item['product_name'] as String? ?? 'Unknown Product';
                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                    final price = (item['product_price'] as num?)?.toInt() ?? 0;
                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                    final stock = (item['product_stock'] as num?)?.toInt() ?? 0;
                    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                    return Padding(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      child: WishlistItemTile(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        productName: productName,
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        categoryName: item['category_name'] as String? ?? 'Unknown',
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        price: price,
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        statusLabel: 'Stok $stock',
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        onRemove: () => _removeWishlist(productId, productName),
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    );
                  // Menutup blok kode agar struktur Dart tetap valid.
                  },
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
