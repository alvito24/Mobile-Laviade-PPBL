// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/foundation.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../data/database/database_helper.dart';

/// Loads local statistics from SQLite for the Insight screen; no online analytics involved.
// Mendefinisikan class utama untuk bagian fitur ini.
class InsightProvider extends ChangeNotifier {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final DatabaseHelper _db = DatabaseHelper.instance;

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool isLoading = false;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  String? errorMessage;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  Map<String, int> countSummary = const {};
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  double totalOrderAmount = 0;
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  double cartEstimatedTotal = 0;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  List<Map<String, dynamic>> orderStatusDistribution = const [];

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool get isAllEmpty {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final countTotal = countSummary.values.fold<int>(0, (sum, value) => sum + value);
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return countTotal == 0 && totalOrderAmount == 0 && cartEstimatedTotal == 0;
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Aggregates all insight values in one load so the screen refreshes consistently.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> loadInsights() async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    isLoading = true;
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Memberi tahu UI bahwa data Provider sudah berubah.
    notifyListeners();

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      countSummary = await _db.getLocalCountSummary();
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      totalOrderAmount = await _db.getTotalOrderAmount();
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      cartEstimatedTotal = await _db.getCartEstimatedTotal();
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      orderStatusDistribution = await _db.getOrderStatusDistribution();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Insight statistik lokal gagal dimuat.';
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
// Menutup blok kode agar struktur Dart tetap valid.
}
