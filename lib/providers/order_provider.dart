// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/foundation.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../data/database/database_helper.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../models/order_item_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../models/order_simulation_model.dart';

/// Manages local order simulation state while SQLite remains the source of truth.
// Mendefinisikan class utama untuk bagian fitur ini.
class OrderProvider extends ChangeNotifier {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final DatabaseHelper _db = DatabaseHelper.instance;

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool isLoading = false;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  String? errorMessage;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  List<OrderSimulationModel> orders = [];
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  OrderSimulationModel? selectedOrder;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  List<OrderItemModel> selectedOrderItems = [];

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> loadOrders() async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    isLoading = true;
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Memberi tahu UI bahwa data Provider sudah berubah.
    notifyListeners();

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      orders = await _db.getOrders();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Simulasi order lokal gagal dimuat.';
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

  // Creates an order snapshot from current cart items; it does not perform real checkout.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> createOrderFromCart({String? note}) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.createOrderSimulationFromCart(note: note);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadOrders();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Simulasi order lokal gagal dibuat.';
      // Memberi tahu UI bahwa data Provider sudah berubah.
      notifyListeners();
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      rethrow;
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> loadOrderDetail(int orderId) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    isLoading = true;
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Memberi tahu UI bahwa data Provider sudah berubah.
    notifyListeners();

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      selectedOrder = await _db.getOrderById(orderId);
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      selectedOrderItems = await _db.getOrderItems(orderId);
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (selectedOrder == null) {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        errorMessage = 'Simulasi order lokal tidak ditemukan.';
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Detail simulasi order lokal gagal dimuat.';
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
  Future<void> updateOrderStatus(int orderId, String status) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.updateOrderStatus(orderId, status);
      // Refresh both detail and list so status changes are visible in every order screen.
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadOrderDetail(orderId);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadOrders();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Status simulasi order gagal diperbarui.';
      // Memberi tahu UI bahwa data Provider sudah berubah.
      notifyListeners();
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      rethrow;
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> deleteOrder(int orderId) async {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    errorMessage = null;
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.deleteOrder(orderId);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      selectedOrder = null;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      selectedOrderItems = [];
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await loadOrders();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      errorMessage = 'Simulasi order lokal gagal dihapus.';
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
