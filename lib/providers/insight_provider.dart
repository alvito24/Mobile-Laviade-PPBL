import 'package:flutter/foundation.dart';

import '../data/database/database_helper.dart';

class InsightProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;

  bool isLoading = false;
  String? errorMessage;
  Map<String, int> countSummary = const {};
  double totalOrderAmount = 0;
  double cartEstimatedTotal = 0;
  List<Map<String, dynamic>> orderStatusDistribution = const [];

  bool get isAllEmpty {
    final countTotal = countSummary.values.fold<int>(0, (sum, value) => sum + value);
    return countTotal == 0 && totalOrderAmount == 0 && cartEstimatedTotal == 0;
  }

  Future<void> loadInsights() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      countSummary = await _db.getLocalCountSummary();
      totalOrderAmount = await _db.getTotalOrderAmount();
      cartEstimatedTotal = await _db.getCartEstimatedTotal();
      orderStatusDistribution = await _db.getOrderStatusDistribution();
    } catch (e) {
      errorMessage = 'Insight statistik lokal gagal dimuat.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
