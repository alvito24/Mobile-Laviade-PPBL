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
import '../../data/database/database_helper.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/product_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../providers/wishlist_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/category_chip.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/empty_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/error_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/primary_button.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/stock_badge.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../notes/product_note_screen.dart';

// Mendefinisikan class utama untuk bagian fitur ini.
class ProductDetailScreen extends StatefulWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const ProductDetailScreen({super.key, required this.productId});

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final int productId;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final _db = DatabaseHelper.instance;
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool _isAddingToCart = false;

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _addToCart(ProductModel product) async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (_isAddingToCart) return;
    
    // Memperbarui state lokal agar UI menampilkan data terbaru.
    setState(() => _isAddingToCart = true);

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.addToCart(product.id!);
      
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SnackBar(content: Text('Produk berhasil ditambahkan ke cart.')),
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
          SnackBar(content: Text('Gagal menambahkan ke cart: $e')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    } finally {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Memperbarui state lokal agar UI menampilkan data terbaru.
        setState(() => _isAddingToCart = false);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Wishlist is an extension action; Add to Cart remains the original A2 flow.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _toggleWishlist(ProductModel product) async {
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menghubungkan UI dengan state Provider yang ringan.
      await context.read<WishlistProvider>().toggleWishlist(product.id!);
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final isWishlisted = context
          // Menghubungkan UI dengan state Provider yang ringan.
          .read<WishlistProvider>()
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          .wishlistedProductIds
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          .contains(product.id);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SnackBar(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            content: Text(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              isWishlisted
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  ? 'Produk disimpan ke wishlist lokal.'
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  : 'Produk dihapus dari wishlist lokal.',
            // Menutup blok kode agar struktur Dart tetap valid.
            ),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
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
        ..showSnackBar(SnackBar(content: Text('Wishlist gagal diperbarui: $e')));
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Product notes need product context so notes stay scoped to the selected product.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void _openProductNotes(ProductModel product) {
    // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
    Navigator.of(context).push(
      // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
      MaterialPageRoute<void>(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        builder: (_) => ProductNoteScreen(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          productId: product.id!,
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          productName: product.name,
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return Scaffold(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      appBar: AppBar(title: const Text('Product Detail')),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      body: SafeArea(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        child: FutureBuilder<ProductModel?>(
          // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
          future: _db.getProductById(widget.productId),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          builder: (context, snapshot) {
            // Memeriksa kondisi agar alur aplikasi tetap aman.
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mengembalikan hasil yang dibutuhkan pemanggil kode.
              return const Center(child: CircularProgressIndicator());
            // Menutup blok kode agar struktur Dart tetap valid.
            }

            // Memeriksa kondisi agar alur aplikasi tetap aman.
            if (snapshot.hasError) {
              // Mengembalikan hasil yang dibutuhkan pemanggil kode.
              return ErrorState(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                title: 'Detail produk gagal dimuat.',
                // Memperbarui state lokal agar UI menampilkan data terbaru.
                onAction: () => setState(() {}),
              // Menutup blok kode agar struktur Dart tetap valid.
              );
            // Menutup blok kode agar struktur Dart tetap valid.
            }

            // Menyimpan nilai yang dipakai oleh alur fitur ini.
            final product = snapshot.data;
            // Memeriksa kondisi agar alur aplikasi tetap aman.
            if (product == null) {
              // Mengembalikan hasil yang dibutuhkan pemanggil kode.
              return EmptyState(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                title: 'Produk tidak ditemukan.',
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                description: 'Produk mungkin sudah dihapus dari database lokal.',
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                actionLabel: 'Kembali ke Katalog',
                // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
                onAction: () => Navigator.of(context).pop(),
              // Menutup blok kode agar struktur Dart tetap valid.
              );
            // Menutup blok kode agar struktur Dart tetap valid.
            }

            // Menghubungkan UI dengan state Provider yang ringan.
            context.read<WishlistProvider>().isWishlisted(product.id!);

            // Mengembalikan hasil yang dibutuhkan pemanggil kode.
            return ListView(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              padding: const EdgeInsets.all(AppSpacing.md),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              children: [
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                Container(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  height: 280,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  decoration: BoxDecoration(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    color: AppColors.surfaceMuted,
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    border: Border.all(color: AppColors.border),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  child: Center(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    child: Text(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      product.imageName ?? 'product.png',
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      style: const TextStyle(fontWeight: FontWeight.w800),
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      textAlign: TextAlign.center,
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.lg),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                Row(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  children: [
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    CategoryChip(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      label: product.categoryName ?? 'Unknown',
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      isSelected: true,
                      // Menangani interaksi pengguna pada komponen ini.
                      onTap: () {},
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                    const SizedBox(width: AppSpacing.sm),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    StockBadge(stock: product.stock),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ],
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.md),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                Text(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  product.name,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  style: Theme.of(context).textTheme.headlineLarge,
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.sm),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                Text(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  CurrencyFormatter.formatRupiah(product.price),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  style: Theme.of(context).textTheme.headlineMedium,
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.lg),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                Text('Deskripsi', style: Theme.of(context).textTheme.titleLarge),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.sm),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                Text(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  product.description ?? 'Tidak ada deskripsi.',
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  style: const TextStyle(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    color: AppColors.textSecondary,
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    height: 1.5,
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.lg),
                // Menghubungkan UI dengan state Provider yang ringan.
                Consumer<WishlistProvider>(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  builder: (context, provider, _) {
                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                    final isWishlisted = provider.wishlistedProductIds.contains(product.id);
                    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                    return OutlinedButton.icon(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      onPressed: () => _toggleWishlist(product),
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      icon: Icon(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      label: Text(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        isWishlisted ? 'Tersimpan di Wishlist' : 'Simpan ke Wishlist',
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    );
                  // Menutup blok kode agar struktur Dart tetap valid.
                  },
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                OutlinedButton.icon(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  onPressed: () => _openProductNotes(product),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  icon: const Icon(Icons.note_alt_outlined),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  label: const Text('Catatan Produk'),
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const SizedBox(height: AppSpacing.md),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                PrimaryButton(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  label: _isAddingToCart ? 'Menambahkan...' : 'Tambah ke Cart',
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  icon: Icons.shopping_bag_outlined,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  onPressed: _isAddingToCart ? null : () => _addToCart(product),
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
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}
