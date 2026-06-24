import 'package:flutter/foundation.dart';

import '../data/database/database_helper.dart';
import '../models/product_note_model.dart';

class ProductNoteProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;

  bool isLoading = false;
  String? errorMessage;
  List<ProductNoteModel> notes = [];

  Future<void> loadNotes(int productId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      notes = await _db.getProductNotesByProductId(productId);
    } catch (e) {
      errorMessage = 'Catatan produk gagal dimuat.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote({
    required int productId,
    String? title,
    required String note,
  }) async {
    errorMessage = null;
    try {
      await _db.addProductNote(
        ProductNoteModel(productId: productId, title: title, note: note),
      );
      await loadNotes(productId);
    } catch (e) {
      errorMessage = 'Catatan produk gagal disimpan.';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateNote(ProductNoteModel note) async {
    errorMessage = null;
    try {
      await _db.updateProductNote(note);
      await loadNotes(note.productId);
    } catch (e) {
      errorMessage = 'Catatan produk gagal diperbarui.';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteNote(int noteId, int productId) async {
    errorMessage = null;
    try {
      await _db.deleteProductNote(noteId);
      await loadNotes(productId);
    } catch (e) {
      errorMessage = 'Catatan produk gagal dihapus.';
      notifyListeners();
      rethrow;
    }
  }
}
