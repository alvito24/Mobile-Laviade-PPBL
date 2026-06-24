// Mengambil package atau file lain yang dipakai di file ini.
import 'package:sqflite/sqflite.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'package:path/path.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/category_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/product_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/cart_item_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/wishlist_item_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/order_simulation_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/order_item_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/product_note_model.dart';

/// Central SQLite helper for Assessment 2 baseline and Tugas Besar extensions.
// Mendefinisikan class utama untuk bagian fitur ini.
class DatabaseHelper {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  static final DatabaseHelper instance = DatabaseHelper._init();
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  static Database? _database;

  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  DatabaseHelper._init();

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<Database> get database async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (_database != null) return _database!;
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _database = await _initDB('laviade.db');
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return _database!;
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<Database> _initDB(String filePath) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final dbPath = await getDatabasesPath();
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final path = join(dbPath, filePath);

    // Version 2 keeps A2 tables and adds local Tugas Besar tables through onUpgrade.
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await openDatabase(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      path,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      version: 2,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      onCreate: _createDB,
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      onUpgrade: _upgradeDB,
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _createDB(Database db, int version) async {
    // Create categories table
    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.execute('''
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      CREATE TABLE categories (
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        name TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        created_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        updated_at TEXT NOT NULL
      // Menutup blok kode agar struktur Dart tetap valid.
      )
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');

    // Create products table
    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.execute('''
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      CREATE TABLE products (
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        category_id INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        name TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        price INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        stock INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        description TEXT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        image_name TEXT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        created_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        updated_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        FOREIGN KEY (category_id) REFERENCES categories (id)
      // Menutup blok kode agar struktur Dart tetap valid.
      )
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');

    // Create cart_items table
    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.execute('''
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      CREATE TABLE cart_items (
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        product_id INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        quantity INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        created_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        updated_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        FOREIGN KEY (product_id) REFERENCES products (id)
      // Menutup blok kode agar struktur Dart tetap valid.
      )
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');

    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    await _createTugasBesarTables(db);
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Creates Tugas Besar tables for users upgrading from Assessment 2 database v1.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (oldVersion < 2) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await _createTugasBesarTables(db);
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Adds new local-first feature tables without dropping existing A2 data.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _createTugasBesarTables(Database db) async {
    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.execute('''
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      CREATE TABLE IF NOT EXISTS wishlist_items (
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        product_id INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        created_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        UNIQUE(product_id),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        FOREIGN KEY (product_id) REFERENCES products (id)
      // Menutup blok kode agar struktur Dart tetap valid.
      )
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');

    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.execute('''
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      CREATE TABLE IF NOT EXISTS orders (
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        order_code TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        created_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        status TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        total_amount REAL NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        total_items INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        note TEXT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        UNIQUE(order_code)
      // Menutup blok kode agar struktur Dart tetap valid.
      )
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');

    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.execute('''
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      CREATE TABLE IF NOT EXISTS order_items (
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        order_id INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        product_id INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        product_name_snapshot TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        product_price_snapshot REAL NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        quantity INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        subtotal REAL NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        FOREIGN KEY (order_id) REFERENCES orders (id),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        FOREIGN KEY (product_id) REFERENCES products (id)
      // Menutup blok kode agar struktur Dart tetap valid.
      )
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');

    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.execute('''
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      CREATE TABLE IF NOT EXISTS product_notes (
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        product_id INTEGER NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        title TEXT,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        note TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        created_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        updated_at TEXT NOT NULL,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        FOREIGN KEY (product_id) REFERENCES products (id)
      // Menutup blok kode agar struktur Dart tetap valid.
      )
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // ========== CATEGORY CRUD ==========

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> insertCategory(CategoryModel category) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.insert('categories', category.toMap());
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<CategoryModel>> getCategories() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.query('categories', orderBy: 'name ASC');
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return result.map((map) => CategoryModel.fromMap(map)).toList();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<CategoryModel?> getCategoryById(int id) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.query(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'categories',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [id],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
    
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (result.isNotEmpty) {
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return CategoryModel.fromMap(result.first);
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return null;
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> updateCategory(CategoryModel category) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.update(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'categories',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      category.copyWith(updatedAt: DateTime.now().toIso8601String()).toMap(),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [category.id],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> deleteCategory(int id) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    
    // Check if category is used by any product
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final products = await db.query(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'products',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'category_id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [id],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
    
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (products.isNotEmpty) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Kategori tidak dapat dihapus karena masih digunakan produk');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.delete(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'categories',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [id],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // ========== PRODUCT CRUD ==========

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> insertProduct(ProductModel product) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.insert('products', product.toMap());
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<ProductModel>> getProducts() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.rawQuery('''
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      SELECT p.*, c.name as category_name
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      FROM products p
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LEFT JOIN categories c ON p.category_id = c.id
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ORDER BY p.created_at DESC
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return result.map((map) => ProductModel.fromMap(map)).toList();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.rawQuery('''
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      SELECT p.*, c.name as category_name
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      FROM products p
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LEFT JOIN categories c ON p.category_id = c.id
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      WHERE p.category_id = ?
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ORDER BY p.created_at DESC
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''', [categoryId]);
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return result.map((map) => ProductModel.fromMap(map)).toList();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<ProductModel?> getProductById(int id) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.rawQuery('''
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      SELECT p.*, c.name as category_name
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      FROM products p
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LEFT JOIN categories c ON p.category_id = c.id
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      WHERE p.id = ?
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''', [id]);
    
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (result.isNotEmpty) {
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return ProductModel.fromMap(result.first);
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return null;
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> updateProduct(ProductModel product) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.update(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'products',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      product.copyWith(updatedAt: DateTime.now().toIso8601String()).toMap(),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [product.id],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> deleteProduct(int id) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    
    // Optional: Delete cart items with this product
    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.delete(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'cart_items',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'product_id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [id],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
    
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.delete(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'products',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [id],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // ========== CART CRUD ==========

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> addToCart(int productId, {int quantity = 1}) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;

    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (quantity < 1) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Quantity tidak boleh kurang dari 1');
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final product = await getProductById(productId);
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (product == null) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Produk tidak ditemukan.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    
    // Check if product already in cart
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final existing = await db.query(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'cart_items',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'product_id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [productId],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
    
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (existing.isNotEmpty) {
      // Update quantity if product already exists
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final cartItem = CartItemModel.fromMap(existing.first);
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final newQuantity = cartItem.quantity + quantity;
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (newQuantity > product.stock) {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        throw Exception('Stok produk tidak mencukupi.');
      // Menutup blok kode agar struktur Dart tetap valid.
      }
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return await updateCartQuantity(cartItem.id!, newQuantity);
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    } else {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (quantity > product.stock) {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        throw Exception('Stok produk tidak mencukupi.');
      // Menutup blok kode agar struktur Dart tetap valid.
      }

      // Insert new cart item
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final cartItem = CartItemModel(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        productId: productId,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        quantity: quantity,
      // Menutup blok kode agar struktur Dart tetap valid.
      );
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return await db.insert('cart_items', cartItem.toMap());
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<CartItemModel>> getCartItems() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.rawQuery('''
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      SELECT 
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        c.id,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        c.product_id,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        c.quantity,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        c.created_at,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        c.updated_at,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        p.name as product_name,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        p.price as product_price,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        p.image_name as product_image_name
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      FROM cart_items c
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LEFT JOIN products p ON c.product_id = p.id
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ORDER BY c.created_at DESC
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return result.map((map) => CartItemModel.fromMap(map)).toList();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> updateCartQuantity(int cartItemId, int newQuantity) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (newQuantity < 1) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Quantity tidak boleh kurang dari 1');
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final cartRows = await db.query(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'cart_items',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [cartItemId],
    // Menutup blok kode agar struktur Dart tetap valid.
    );

    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (cartRows.isEmpty) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Item cart tidak ditemukan.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final cartItem = CartItemModel.fromMap(cartRows.first);
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final product = await getProductById(cartItem.productId);
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (product == null) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Produk tidak ditemukan.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (newQuantity > product.stock) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Stok produk tidak mencukupi.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.update(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'cart_items',
      // Menutup blok kode agar struktur Dart tetap valid.
      {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        'quantity': newQuantity,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        'updated_at': DateTime.now().toIso8601String(),
      // Menutup blok kode agar struktur Dart tetap valid.
      },
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [cartItemId],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> deleteCartItem(int cartItemId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.delete(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'cart_items',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [cartItemId],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> clearCart() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.delete('cart_items');
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> getCartTotal() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final cartItems = await getCartItems();
    // Menjalankan fungsi penting untuk kebutuhan fitur ini.
    int total = 0;
    // Melakukan perulangan untuk memproses data yang tersedia.
    for (var item in cartItems) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      total += item.getSubtotal();
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return total;
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // ========== WISHLIST ITEM CRUD ==========

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> addWishlistItem(int productId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final product = await getProductById(productId);
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (product == null) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Produk tidak ditemukan.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final item = WishlistItemModel(productId: productId);
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.insert(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'wishlist_items',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      item.toMap(),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      conflictAlgorithm: ConflictAlgorithm.ignore,
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> removeWishlistItem(int productId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.delete(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'wishlist_items',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'product_id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [productId],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<bool> isProductWishlisted(int productId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.query(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'wishlist_items',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'product_id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [productId],
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      limit: 1,
    // Menutup blok kode agar struktur Dart tetap valid.
    );
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return result.isNotEmpty;
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<Map<String, dynamic>>> getWishlistProducts() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.rawQuery('''
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      SELECT
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        w.id as wishlist_id,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        w.product_id,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        w.created_at as wishlist_created_at,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        p.name as product_name,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        p.price as product_price,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        p.stock as product_stock,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        p.image_name as product_image_name,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        c.name as category_name
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      FROM wishlist_items w
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LEFT JOIN products p ON w.product_id = p.id
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      LEFT JOIN categories c ON p.category_id = c.id
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ORDER BY w.created_at DESC
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> clearWishlist() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.delete('wishlist_items');
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // ========== ORDER SIMULATION CRUD ==========

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> createOrderSimulationFromCart({String? note}) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final cartItems = await getCartItems();
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (cartItems.isEmpty) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Cart masih kosong.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.transaction<int>((txn) async {
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final now = DateTime.now();
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final createdAt = now.toIso8601String();
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final orderCode = _generateOrderCode(now);
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final totalAmount = cartItems.fold<double>(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        0,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        (sum, item) => sum + item.getSubtotal(),
      // Menutup blok kode agar struktur Dart tetap valid.
      );
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final totalItems = cartItems.fold<int>(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        0,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        (sum, item) => sum + item.quantity,
      // Menutup blok kode agar struktur Dart tetap valid.
      );

      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final orderId = await txn.insert(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        'orders',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        OrderSimulationModel(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          orderCode: orderCode,
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          createdAt: createdAt,
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          status: 'dibuat',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          totalAmount: totalAmount,
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          totalItems: totalItems,
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          note: note,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ).toMap(),
      // Menutup blok kode agar struktur Dart tetap valid.
      );

      // Melakukan perulangan untuk memproses data yang tersedia.
      for (final item in cartItems) {
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        final price = (item.productPrice ?? 0).toDouble();
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        await txn.insert(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          'order_items',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          OrderItemModel(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            orderId: orderId,
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            productId: item.productId,
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            productNameSnapshot: item.productName ?? 'Unknown Product',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            productPriceSnapshot: price,
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            quantity: item.quantity,
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            subtotal: price * item.quantity,
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ).toMap(),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
      // Menutup blok kode agar struktur Dart tetap valid.
      }

      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return orderId;
    // Menutup blok kode agar struktur Dart tetap valid.
    });
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<OrderSimulationModel>> getOrders() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.query('orders', orderBy: 'created_at DESC');
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return result.map((map) => OrderSimulationModel.fromMap(map)).toList();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<OrderSimulationModel?> getOrderById(int orderId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.query(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'orders',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [orderId],
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      limit: 1,
    // Menutup blok kode agar struktur Dart tetap valid.
    );
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (result.isEmpty) return null;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return OrderSimulationModel.fromMap(result.first);
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<OrderItemModel>> getOrderItems(int orderId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.query(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'order_items',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'order_id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [orderId],
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      orderBy: 'id ASC',
    // Menutup blok kode agar struktur Dart tetap valid.
    );
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return result.map((map) => OrderItemModel.fromMap(map)).toList();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> updateOrderStatus(int orderId, String status) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    const allowedStatuses = {'dibuat', 'diproses', 'selesai', 'dibatalkan'};
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (!allowedStatuses.contains(status)) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Status simulasi order tidak valid.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.update(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'orders',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      {'status': status},
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [orderId],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> deleteOrder(int orderId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.transaction<int>((txn) async {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await txn.delete(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        'order_items',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        where: 'order_id = ?',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        whereArgs: [orderId],
      // Menutup blok kode agar struktur Dart tetap valid.
      );
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return await txn.delete('orders', where: 'id = ?', whereArgs: [orderId]);
    // Menutup blok kode agar struktur Dart tetap valid.
    });
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // ========== PRODUCT NOTE CRUD ==========

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> addProductNote(ProductNoteModel note) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (note.note.trim().isEmpty) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Catatan produk tidak boleh kosong.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final product = await getProductById(note.productId);
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (product == null) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Produk tidak ditemukan.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.insert('product_notes', note.toMap());
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<ProductNoteModel>> getProductNotesByProductId(int productId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.query(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'product_notes',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'product_id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [productId],
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      orderBy: 'updated_at DESC',
    // Menutup blok kode agar struktur Dart tetap valid.
    );
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return result.map((map) => ProductNoteModel.fromMap(map)).toList();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> updateProductNote(ProductNoteModel note) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (note.id == null) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('ID catatan produk wajib ada untuk update.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (note.note.trim().isEmpty) {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      throw Exception('Catatan produk tidak boleh kosong.');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.update(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'product_notes',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      note.copyWith(updatedAt: DateTime.now().toIso8601String()).toMap(),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [note.id],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> deleteProductNote(int noteId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.delete('product_notes', where: 'id = ?', whereArgs: [noteId]);
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<int> deleteProductNotesByProductId(int productId) async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.delete(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'product_notes',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      where: 'product_id = ?',
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      whereArgs: [productId],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // ========== LOCAL STATISTICS ==========

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<Map<String, int>> getLocalCountSummary() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'products': Sqflite.firstIntValue(
            // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
            await db.rawQuery('SELECT COUNT(*) FROM products'),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ) ??
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          0,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'categories': Sqflite.firstIntValue(
            // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
            await db.rawQuery('SELECT COUNT(*) FROM categories'),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ) ??
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          0,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'cart_items': Sqflite.firstIntValue(
            // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
            await db.rawQuery('SELECT COUNT(*) FROM cart_items'),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ) ??
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          0,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'wishlist_items': Sqflite.firstIntValue(
            // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
            await db.rawQuery('SELECT COUNT(*) FROM wishlist_items'),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ) ??
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          0,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'orders': Sqflite.firstIntValue(
            // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
            await db.rawQuery('SELECT COUNT(*) FROM orders'),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ) ??
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          0,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      'product_notes': Sqflite.firstIntValue(
            // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
            await db.rawQuery('SELECT COUNT(*) FROM product_notes'),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ) ??
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          0,
    // Menutup blok kode agar struktur Dart tetap valid.
    };
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<double> getTotalOrderAmount() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final result = await db.rawQuery('SELECT SUM(total_amount) FROM orders');
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final value = result.first.values.first;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return value == null ? 0 : (value as num).toDouble();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<double> getCartEstimatedTotal() async {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return (await getCartTotal()).toDouble();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<List<Map<String, dynamic>>> getOrderStatusDistribution() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return await db.rawQuery('''
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      SELECT status, COUNT(*) as count
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      FROM orders
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      GROUP BY status
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ORDER BY status ASC
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ''');
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  String _generateOrderCode(DateTime dateTime) {
    // Menjalankan fungsi penting untuk kebutuhan fitur ini.
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return 'LVD-${dateTime.year}'
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        '${twoDigits(dateTime.month)}'
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        '${twoDigits(dateTime.day)}-'
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        '${twoDigits(dateTime.hour)}'
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        '${twoDigits(dateTime.minute)}'
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        '${twoDigits(dateTime.second)}';
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // ========== UTILITY ==========

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> close() async {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final db = await database;
    // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
    await db.close();
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}
