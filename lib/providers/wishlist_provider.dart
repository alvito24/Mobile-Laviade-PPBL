// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/foundation.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../data/database/database_helper.dart';

/// Keeps wishlist UI in sync with SQLite without storing permanent data in Provider.
// Mendefinisikan class utama untuk bagian fitur ini.
class WishlistProvider extends ChangeNotifier {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final DatabaseHelper _db = DatabaseHelper.instance;

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool isLoading = false;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  String? errorMessage;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  List<Map<String, dynamic>> wishlistProducts = [];
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  Set<int> wishlistedProductIds = {};

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> loadWishlist() async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    isLoading = true;
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Memberi tahu UI bahwa data Provider sudah berubah.
    notifyListeners();

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final products = await _db.getWishlistProducts();
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      wishlistProducts = products;
      // Cache product IDs so Product Detail can render the heart state quickly.
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      wishlistedProductIds = products
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          .map((item) => item['product_id'])
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          .whereType<int>()
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          .toSet();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Wishlist gagal dimuat.';
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    } finally {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      isLoading = false;
      // Memberi tahu UI bahwa data Provider sudah berubah.
      notifyListeners();
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<bool> isWishlisted(int productId) async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (wishlistedProductIds.contains(productId)) return true;

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final exists = await _db.isProductWishlisted(productId);
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (exists) {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        wishlistedProductIds = {...wishlistedProductIds, productId};
        // Memberi tahu UI bahwa data Provider sudah berubah.
        notifyListeners();
      // Menutup blok kode agar struktur Dart tetap valid.
      }
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return exists;
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Status wishlist gagal dicek.';
      // Memberi tahu UI bahwa data Provider sudah berubah.
      notifyListeners();
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return false;
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Toggle is used by Product Detail so one button can add or remove wishlist.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> toggleWishlist(int productId) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final exists = await _db.isProductWishlisted(productId);
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (exists) {
        // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
        await _db.removeWishlistItem(productId);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      } else {
        // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
        await _db.addWishlistItem(productId);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadWishlist();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Wishlist gagal diperbarui.';
      // Memberi tahu UI bahwa data Provider sudah berubah.
      notifyListeners();
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      rethrow;
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> removeWishlist(int productId) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.removeWishlistItem(productId);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadWishlist();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Produk gagal dihapus dari wishlist.';
      // Memberi tahu UI bahwa data Provider sudah berubah.
      notifyListeners();
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      rethrow;
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}
