import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../models/cart_item_model.dart';
import '../../models/wishlist_item_model.dart';
import '../../models/order_simulation_model.dart';
import '../../models/order_item_model.dart';
import '../../models/product_note_model.dart';

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
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
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

    await _createTugasBesarTables(db);
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createTugasBesarTables(db);
    }
  }

  Future<void> _createTugasBesarTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS wishlist_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        UNIQUE(product_id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_code TEXT NOT NULL,
        created_at TEXT NOT NULL,
        status TEXT NOT NULL,
        total_amount REAL NOT NULL,
        total_items INTEGER NOT NULL,
        note TEXT,
        UNIQUE(order_code)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        product_name_snapshot TEXT NOT NULL,
        product_price_snapshot REAL NOT NULL,
        quantity INTEGER NOT NULL,
        subtotal REAL NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS product_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        title TEXT,
        note TEXT NOT NULL,
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

  // ========== WISHLIST ITEM CRUD ==========

  Future<int> addWishlistItem(int productId) async {
    final db = await database;
    final product = await getProductById(productId);
    if (product == null) {
      throw Exception('Produk tidak ditemukan.');
    }

    final item = WishlistItemModel(productId: productId);
    return await db.insert(
      'wishlist_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> removeWishlistItem(int productId) async {
    final db = await database;
    return await db.delete(
      'wishlist_items',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }

  Future<bool> isProductWishlisted(int productId) async {
    final db = await database;
    final result = await db.query(
      'wishlist_items',
      where: 'product_id = ?',
      whereArgs: [productId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getWishlistProducts() async {
    final db = await database;
    return await db.rawQuery('''
      SELECT
        w.id as wishlist_id,
        w.product_id,
        w.created_at as wishlist_created_at,
        p.name as product_name,
        p.price as product_price,
        p.stock as product_stock,
        p.image_name as product_image_name,
        c.name as category_name
      FROM wishlist_items w
      LEFT JOIN products p ON w.product_id = p.id
      LEFT JOIN categories c ON p.category_id = c.id
      ORDER BY w.created_at DESC
    ''');
  }

  Future<int> clearWishlist() async {
    final db = await database;
    return await db.delete('wishlist_items');
  }

  // ========== ORDER SIMULATION CRUD ==========

  Future<int> createOrderSimulationFromCart({String? note}) async {
    final db = await database;
    final cartItems = await getCartItems();
    if (cartItems.isEmpty) {
      throw Exception('Cart masih kosong.');
    }

    return await db.transaction<int>((txn) async {
      final now = DateTime.now();
      final createdAt = now.toIso8601String();
      final orderCode = _generateOrderCode(now);
      final totalAmount = cartItems.fold<double>(
        0,
        (sum, item) => sum + item.getSubtotal(),
      );
      final totalItems = cartItems.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

      final orderId = await txn.insert(
        'orders',
        OrderSimulationModel(
          orderCode: orderCode,
          createdAt: createdAt,
          status: 'dibuat',
          totalAmount: totalAmount,
          totalItems: totalItems,
          note: note,
        ).toMap(),
      );

      for (final item in cartItems) {
        final price = (item.productPrice ?? 0).toDouble();
        await txn.insert(
          'order_items',
          OrderItemModel(
            orderId: orderId,
            productId: item.productId,
            productNameSnapshot: item.productName ?? 'Unknown Product',
            productPriceSnapshot: price,
            quantity: item.quantity,
            subtotal: price * item.quantity,
          ).toMap(),
        );
      }

      return orderId;
    });
  }

  Future<List<OrderSimulationModel>> getOrders() async {
    final db = await database;
    final result = await db.query('orders', orderBy: 'created_at DESC');
    return result.map((map) => OrderSimulationModel.fromMap(map)).toList();
  }

  Future<OrderSimulationModel?> getOrderById(int orderId) async {
    final db = await database;
    final result = await db.query(
      'orders',
      where: 'id = ?',
      whereArgs: [orderId],
      limit: 1,
    );
    if (result.isEmpty) return null;
    return OrderSimulationModel.fromMap(result.first);
  }

  Future<List<OrderItemModel>> getOrderItems(int orderId) async {
    final db = await database;
    final result = await db.query(
      'order_items',
      where: 'order_id = ?',
      whereArgs: [orderId],
      orderBy: 'id ASC',
    );
    return result.map((map) => OrderItemModel.fromMap(map)).toList();
  }

  Future<int> updateOrderStatus(int orderId, String status) async {
    final db = await database;
    const allowedStatuses = {'dibuat', 'diproses', 'selesai', 'dibatalkan'};
    if (!allowedStatuses.contains(status)) {
      throw Exception('Status simulasi order tidak valid.');
    }
    return await db.update(
      'orders',
      {'status': status},
      where: 'id = ?',
      whereArgs: [orderId],
    );
  }

  Future<int> deleteOrder(int orderId) async {
    final db = await database;
    return await db.transaction<int>((txn) async {
      await txn.delete(
        'order_items',
        where: 'order_id = ?',
        whereArgs: [orderId],
      );
      return await txn.delete('orders', where: 'id = ?', whereArgs: [orderId]);
    });
  }

  // ========== PRODUCT NOTE CRUD ==========

  Future<int> addProductNote(ProductNoteModel note) async {
    final db = await database;
    if (note.note.trim().isEmpty) {
      throw Exception('Catatan produk tidak boleh kosong.');
    }
    final product = await getProductById(note.productId);
    if (product == null) {
      throw Exception('Produk tidak ditemukan.');
    }
    return await db.insert('product_notes', note.toMap());
  }

  Future<List<ProductNoteModel>> getProductNotesByProductId(int productId) async {
    final db = await database;
    final result = await db.query(
      'product_notes',
      where: 'product_id = ?',
      whereArgs: [productId],
      orderBy: 'updated_at DESC',
    );
    return result.map((map) => ProductNoteModel.fromMap(map)).toList();
  }

  Future<int> updateProductNote(ProductNoteModel note) async {
    final db = await database;
    if (note.id == null) {
      throw Exception('ID catatan produk wajib ada untuk update.');
    }
    if (note.note.trim().isEmpty) {
      throw Exception('Catatan produk tidak boleh kosong.');
    }
    return await db.update(
      'product_notes',
      note.copyWith(updatedAt: DateTime.now().toIso8601String()).toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteProductNote(int noteId) async {
    final db = await database;
    return await db.delete('product_notes', where: 'id = ?', whereArgs: [noteId]);
  }

  Future<int> deleteProductNotesByProductId(int productId) async {
    final db = await database;
    return await db.delete(
      'product_notes',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }

  // ========== LOCAL STATISTICS ==========

  Future<Map<String, int>> getLocalCountSummary() async {
    final db = await database;
    return {
      'products': Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM products'),
          ) ??
          0,
      'categories': Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM categories'),
          ) ??
          0,
      'cart_items': Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM cart_items'),
          ) ??
          0,
      'wishlist_items': Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM wishlist_items'),
          ) ??
          0,
      'orders': Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM orders'),
          ) ??
          0,
      'product_notes': Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM product_notes'),
          ) ??
          0,
    };
  }

  Future<double> getTotalOrderAmount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(total_amount) FROM orders');
    final value = result.first.values.first;
    return value == null ? 0 : (value as num).toDouble();
  }

  Future<double> getCartEstimatedTotal() async {
    return (await getCartTotal()).toDouble();
  }

  Future<List<Map<String, dynamic>>> getOrderStatusDistribution() async {
    final db = await database;
    return await db.rawQuery('''
      SELECT status, COUNT(*) as count
      FROM orders
      GROUP BY status
      ORDER BY status ASC
    ''');
  }

  String _generateOrderCode(DateTime dateTime) {
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return 'LVD-${dateTime.year}'
        '${twoDigits(dateTime.month)}'
        '${twoDigits(dateTime.day)}-'
        '${twoDigits(dateTime.hour)}'
        '${twoDigits(dateTime.minute)}'
        '${twoDigits(dateTime.second)}';
  }

  // ========== UTILITY ==========

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
