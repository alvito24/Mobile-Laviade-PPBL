import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static final PreferenceHelper instance = PreferenceHelper._init();
  SharedPreferences? _prefs;

  PreferenceHelper._init();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('PreferenceHelper belum diinisialisasi. Panggil init() terlebih dahulu.');
    }
    return _prefs!;
  }

  // ========== KEY CONSTANTS ==========
  static const String keyUserName = 'user_name';
  static const String keyIsDarkMode = 'is_dark_mode';
  static const String keyLastSelectedCategoryId = 'last_selected_category_id';
  static const String keyProductSortType = 'product_sort_type';
  static const String keyPreferredViewMode = 'preferred_view_mode';
  static const String keyCartLastOpened = 'cart_last_opened';

  // ========== DEFAULT VALUES ==========
  static const String defaultUserName = 'Guest';
  static const bool defaultIsDarkMode = false;
  static const String defaultProductSortType = 'default';
  static const String defaultPreferredViewMode = 'grid';

  // ========== USER NAME ==========
  Future<void> saveUserName(String name) async {
    await prefs.setString(keyUserName, name);
  }

  String getUserName() {
    return prefs.getString(keyUserName) ?? defaultUserName;
  }

  // ========== DARK MODE ==========
  Future<void> saveDarkMode(bool isDarkMode) async {
    await prefs.setBool(keyIsDarkMode, isDarkMode);
  }

  bool getDarkMode() {
    return prefs.getBool(keyIsDarkMode) ?? defaultIsDarkMode;
  }

  // ========== LAST SELECTED CATEGORY ID ==========
  Future<void> saveLastSelectedCategoryId(int? categoryId) async {
    if (categoryId == null) {
      await prefs.remove(keyLastSelectedCategoryId);
    } else {
      await prefs.setInt(keyLastSelectedCategoryId, categoryId);
    }
  }

  int? getLastSelectedCategoryId() {
    return prefs.getInt(keyLastSelectedCategoryId);
  }

  // ========== PRODUCT SORT TYPE ==========
  // Valid values: 'default', 'name_asc', 'name_desc', 'price_asc', 'price_desc', 'newest', 'oldest'
  Future<void> saveProductSortType(String sortType) async {
    await prefs.setString(keyProductSortType, sortType);
  }

  String getProductSortType() {
    return prefs.getString(keyProductSortType) ?? defaultProductSortType;
  }

  // ========== PREFERRED VIEW MODE ==========
  // Valid values: 'grid', 'list'
  Future<void> savePreferredViewMode(String viewMode) async {
    if (viewMode != 'grid' && viewMode != 'list') {
      viewMode = defaultPreferredViewMode;
    }
    await prefs.setString(keyPreferredViewMode, viewMode);
  }

  String getPreferredViewMode() {
    final viewMode = prefs.getString(keyPreferredViewMode) ?? defaultPreferredViewMode;
    if (viewMode != 'grid' && viewMode != 'list') {
      return defaultPreferredViewMode;
    }
    return viewMode;
  }

  // ========== CART LAST OPENED ==========
  Future<void> saveCartLastOpened() async {
    final now = DateTime.now().toIso8601String();
    await prefs.setString(keyCartLastOpened, now);
  }

  String? getCartLastOpened() {
    return prefs.getString(keyCartLastOpened);
  }

  // ========== UTILITY ==========
  Future<void> clearAll() async {
    await prefs.clear();
  }

  Future<void> clearPreferences() async {
    await prefs.remove(keyUserName);
    await prefs.remove(keyIsDarkMode);
    await prefs.remove(keyLastSelectedCategoryId);
    await prefs.remove(keyProductSortType);
    await prefs.remove(keyPreferredViewMode);
    await prefs.remove(keyCartLastOpened);
  }
}
