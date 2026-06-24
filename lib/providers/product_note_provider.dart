// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/foundation.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../data/database/database_helper.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../models/product_note_model.dart';

/// Keeps product note CRUD scoped to the selected product.
// Mendefinisikan class utama untuk bagian fitur ini.
class ProductNoteProvider extends ChangeNotifier {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final DatabaseHelper _db = DatabaseHelper.instance;

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool isLoading = false;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  String? errorMessage;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  List<ProductNoteModel> notes = [];

  // Notes are loaded by productId so each product keeps its own local notes.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> loadNotes(int productId) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    isLoading = true;
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Memberi tahu UI bahwa data Provider sudah berubah.
    notifyListeners();

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      notes = await _db.getProductNotesByProductId(productId);
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Catatan produk gagal dimuat.';
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
  Future<void> addNote({
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required int productId,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    String? title,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required String note,
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  }) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.addProductNote(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ProductNoteModel(productId: productId, title: title, note: note),
      // Menutup blok kode agar struktur Dart tetap valid.
      );
      // Reload after insert so the UI list immediately reflects SQLite data.
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadNotes(productId);
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Catatan produk gagal disimpan.';
      // Memberi tahu UI bahwa data Provider sudah berubah.
      notifyListeners();
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      rethrow;
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> updateNote(ProductNoteModel note) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.updateProductNote(note);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadNotes(note.productId);
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Catatan produk gagal diperbarui.';
      // Memberi tahu UI bahwa data Provider sudah berubah.
      notifyListeners();
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      rethrow;
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> deleteNote(int noteId, int productId) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.deleteProductNote(noteId);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadNotes(productId);
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Catatan produk gagal dihapus.';
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
