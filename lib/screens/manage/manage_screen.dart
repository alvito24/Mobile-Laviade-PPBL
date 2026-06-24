// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/material.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_spacing.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/manage_menu_card.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/section_title.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../orders/order_list_screen.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../statistics/insight_statistics_screen.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../wishlist/wishlist_screen.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'manage_category_screen.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'manage_product_screen.dart';

/// Local data hub: feature screens are pushed here instead of adding new bottom tabs.
// Mendefinisikan class utama untuk bagian fitur ini.
class ManageScreen extends StatelessWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const ManageScreen({super.key});

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return ListView(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      padding: const EdgeInsets.all(AppSpacing.md),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      children: [
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SectionTitle(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          title: 'Manage Data',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          subtitle: 'Hub data lokal untuk katalog dan demo CRUD SQLite.',
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SizedBox(height: AppSpacing.lg),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ManageMenuCard(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          title: 'Manage Product',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          description: 'Tambah, edit, dan hapus data produk demo.',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          icon: Icons.inventory_2_outlined,
          // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
          onTap: () => Navigator.of(context).push(
            // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
            MaterialPageRoute<void>(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              builder: (_) => const ManageProductScreen(),
            // Menutup blok kode agar struktur Dart tetap valid.
            ),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SizedBox(height: AppSpacing.md),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ManageMenuCard(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          title: 'Manage Category',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          description: 'Kelola kategori untuk katalog lokal.',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          icon: Icons.category_outlined,
          // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
          onTap: () => Navigator.of(context).push(
            // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
            MaterialPageRoute<void>(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              builder: (_) => const ManageCategoryScreen(),
            // Menutup blok kode agar struktur Dart tetap valid.
            ),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SizedBox(height: AppSpacing.md),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ManageMenuCard(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          title: 'Wishlist Lokal',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          description: 'Lihat dan hapus produk favorit yang tersimpan di SQLite.',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          icon: Icons.favorite_border,
          // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
          onTap: () => Navigator.of(context).push(
            // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
            MaterialPageRoute<void>(builder: (_) => const WishlistScreen()),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SizedBox(height: AppSpacing.md),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ManageMenuCard(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          title: 'Simulasi Order Lokal',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          description: 'Pantau riwayat order simulasi tanpa pembayaran real.',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          icon: Icons.receipt_long_outlined,
          // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
          onTap: () => Navigator.of(context).push(
            // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
            MaterialPageRoute<void>(builder: (_) => const OrderListScreen()),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SizedBox(height: AppSpacing.md),
        // Insight is a Tugas Besar sub-screen, not a new bottom navigation tab.
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ManageMenuCard(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          title: 'Insight Lokal',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          description: 'Lihat statistik SQLite lokal tanpa analytics online.',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          icon: Icons.bar_chart_outlined,
          // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
          onTap: () => Navigator.of(context).push(
            // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
            MaterialPageRoute<void>(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              builder: (_) => const InsightStatisticsScreen(),
            // Menutup blok kode agar struktur Dart tetap valid.
            ),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
      // Menutup blok kode agar struktur Dart tetap valid.
      ],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}
