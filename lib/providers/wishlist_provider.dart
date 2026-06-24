import 'package:flutter/foundation.dart';

import '../data/database/database_helper.dart';

class WishlistProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;

  bool isLoading = false;
  String? errorMessage;
  List<Map<String, dynamic>> wishlistProducts = [];
  Set<int> wishlistedProductIds = {};

  Future<void> loadWishlist() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final products = await _db.getWishlistProducts();
      wishlistProducts = products;
      wishlistedProductIds = products
          .map((item) => item['product_id'])
          .whereType<int>()
          .toSet();
    } catch (e) {
      errorMessage = 'Wishlist gagal dimuat.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> isWishlisted(int productId) async {
    if (wishlistedProductIds.contains(productId)) return true;

    try {
      final exists = await _db.isProductWishlisted(productId);
      if (exists) {
        wishlistedProductIds = {...wishlistedProductIds, productId};
        notifyListeners();
      }
      return exists;
    } catch (e) {
      errorMessage = 'Status wishlist gagal dicek.';
      notifyListeners();
      return false;
    }
  }

  Future<void> toggleWishlist(int productId) async {
    errorMessage = null;
    try {
      final exists = await _db.isProductWishlisted(productId);
      if (exists) {
        await _db.removeWishlistItem(productId);
      } else {
        await _db.addWishlistItem(productId);
      }
      await loadWishlist();
    } catch (e) {
      errorMessage = 'Wishlist gagal diperbarui.';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removeWishlist(int productId) async {
    errorMessage = null;
    try {
      await _db.removeWishlistItem(productId);
      await loadWishlist();
    } catch (e) {
      errorMessage = 'Produk gagal dihapus dari wishlist.';
      notifyListeners();
      rethrow;
    }
  }
}
