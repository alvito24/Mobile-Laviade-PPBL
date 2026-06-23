import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../models/cart_item_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('laviade.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Create categories table
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Create products table
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        price INTEGER NOT NULL,
        stock INTEGER NOT NULL,
        description TEXT,
        image_name TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // Create cart_items table
    await db.execute('''
      CREATE TABLE cart_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');
  }

  // ========== CATEGORY CRUD ==========

  Future<int> insertCategory(CategoryModel category) async {
    final db = await database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<CategoryModel>> getCategories() async {
    final db = await database;
    final result = await db.query('categories', orderBy: 'name ASC');
    return result.map((map) => CategoryModel.fromMap(map)).toList();
  }

  Future<CategoryModel?> getCategoryById(int id) async {
    final db = await database;
    final result = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (result.isNotEmpty) {
      return CategoryModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateCategory(CategoryModel category) async {
    final db = await database;
    return await db.update(
      'categories',
      category.copyWith(updatedAt: DateTime.now().toIso8601String()).toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> deleteCategory(int id) async {
    final db = await database;
    
    // Check if category is used by any product
    final products = await db.query(
      'products',
      where: 'category_id = ?',
      whereArgs: [id],
    );
    
    if (products.isNotEmpty) {
      throw Exception('Kategori tidak dapat dihapus karena masih digunakan produk');
    }
    
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ========== PRODUCT CRUD ==========

  Future<int> insertProduct(ProductModel product) async {
    final db = await database;
    return await db.insert('products', product.toMap());
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT p.*, c.name as category_name
      FROM products p
      LEFT JOIN categories c ON p.category_id = c.id
      ORDER BY p.created_at DESC
    ''');
    return result.map((map) => ProductModel.fromMap(map)).toList();
  }

  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT p.*, c.name as category_name
      FROM products p
      LEFT JOIN categories c ON p.category_id = c.id
      WHERE p.category_id = ?
      ORDER BY p.created_at DESC
    ''', [categoryId]);
    return result.map((map) => ProductModel.fromMap(map)).toList();
  }

  Future<ProductModel?> getProductById(int id) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT p.*, c.name as category_name
      FROM products p
      LEFT JOIN categories c ON p.category_id = c.id
      WHERE p.id = ?
    ''', [id]);
    
    if (result.isNotEmpty) {
      return ProductModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateProduct(ProductModel product) async {
    final db = await database;
    return await db.update(
      'products',
      product.copyWith(updatedAt: DateTime.now().toIso8601String()).toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    
    // Optional: Delete cart items with this product
    await db.delete(
      'cart_items',
      where: 'product_id = ?',
      whereArgs: [id],
    );
    
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ========== CART CRUD ==========

  Future<int> addToCart(int productId, {int quantity = 1}) async {
    final db = await database;

    if (quantity < 1) {
      throw Exception('Quantity tidak boleh kurang dari 1');
    }

    final product = await getProductById(productId);
    if (product == null) {
      throw Exception('Produk tidak ditemukan.');
    }
    
    // Check if product already in cart
    final existing = await db.query(
      'cart_items',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    
    if (existing.isNotEmpty) {
      // Update quantity if product already exists
      final cartItem = CartItemModel.fromMap(existing.first);
      final newQuantity = cartItem.quantity + quantity;
      if (newQuantity > product.stock) {
        throw Exception('Stok produk tidak mencukupi.');
      }
      return await updateCartQuantity(cartItem.id!, newQuantity);
    } else {
      if (quantity > product.stock) {
        throw Exception('Stok produk tidak mencukupi.');
      }

      // Insert new cart item
      final cartItem = CartItemModel(
        productId: productId,
        quantity: quantity,
      );
      return await db.insert('cart_items', cartItem.toMap());
    }
  }

  Future<List<CartItemModel>> getCartItems() async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT 
        c.id,
        c.product_id,
        c.quantity,
        c.created_at,
        c.updated_at,
        p.name as product_name,
        p.price as product_price,
        p.image_name as product_image_name
      FROM cart_items c
      LEFT JOIN products p ON c.product_id = p.id
      ORDER BY c.created_at DESC
    ''');
    return result.map((map) => CartItemModel.fromMap(map)).toList();
  }

  Future<int> updateCartQuantity(int cartItemId, int newQuantity) async {
    final db = await database;
    
    if (newQuantity < 1) {
      throw Exception('Quantity tidak boleh kurang dari 1');
    }

    final cartRows = await db.query(
      'cart_items',
      where: 'id = ?',
      whereArgs: [cartItemId],
    );

    if (cartRows.isEmpty) {
      throw Exception('Item cart tidak ditemukan.');
    }

    final cartItem = CartItemModel.fromMap(cartRows.first);
    final product = await getProductById(cartItem.productId);
    if (product == null) {
      throw Exception('Produk tidak ditemukan.');
    }

    if (newQuantity > product.stock) {
      throw Exception('Stok produk tidak mencukupi.');
    }
    
    return await db.update(
      'cart_items',
      {
        'quantity': newQuantity,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [cartItemId],
    );
  }

  Future<int> deleteCartItem(int cartItemId) async {
    final db = await database;
    return await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [cartItemId],
    );
  }

  Future<int> clearCart() async {
    final db = await database;
    return await db.delete('cart_items');
  }

  Future<int> getCartTotal() async {
    final cartItems = await getCartItems();
    int total = 0;
    for (var item in cartItems) {
      total += item.getSubtotal();
    }
    return total;
  }

  // ========== UTILITY ==========

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
