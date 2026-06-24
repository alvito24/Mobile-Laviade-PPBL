import 'package:flutter/foundation.dart';

import '../data/database/database_helper.dart';
import '../models/order_item_model.dart';
import '../models/order_simulation_model.dart';

class OrderProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;

  bool isLoading = false;
  String? errorMessage;
  List<OrderSimulationModel> orders = [];
  OrderSimulationModel? selectedOrder;
  List<OrderItemModel> selectedOrderItems = [];

  Future<void> loadOrders() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      orders = await _db.getOrders();
    } catch (e) {
      errorMessage = 'Simulasi order lokal gagal dimuat.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createOrderFromCart({String? note}) async {
    errorMessage = null;
    try {
      await _db.createOrderSimulationFromCart(note: note);
      await loadOrders();
    } catch (e) {
      errorMessage = 'Simulasi order lokal gagal dibuat.';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> loadOrderDetail(int orderId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      selectedOrder = await _db.getOrderById(orderId);
      selectedOrderItems = await _db.getOrderItems(orderId);
      if (selectedOrder == null) {
        errorMessage = 'Simulasi order lokal tidak ditemukan.';
      }
    } catch (e) {
      errorMessage = 'Detail simulasi order lokal gagal dimuat.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateOrderStatus(int orderId, String status) async {
    errorMessage = null;
    try {
      await _db.updateOrderStatus(orderId, status);
      await loadOrderDetail(orderId);
      await loadOrders();
    } catch (e) {
      errorMessage = 'Status simulasi order gagal diperbarui.';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteOrder(int orderId) async {
    errorMessage = null;
    try {
      await _db.deleteOrder(orderId);
      selectedOrder = null;
      selectedOrderItems = [];
      await loadOrders();
    } catch (e) {
      errorMessage = 'Simulasi order lokal gagal dihapus.';
      notifyListeners();
      rethrow;
    }
  }
}
