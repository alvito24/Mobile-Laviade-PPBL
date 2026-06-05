import '../database/database_helper.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';

class SeedData {
  static final DatabaseHelper _db = DatabaseHelper.instance;

  // Seed categories
  static Future<void> seedCategories() async {
    final existingCategories = await _db.getCategories();
    
    // Only seed if no categories exist
    if (existingCategories.isEmpty) {
      final categories = [
        CategoryModel(name: 'T-Shirt'),
        CategoryModel(name: 'Hoodie'),
        CategoryModel(name: 'Jacket'),
        CategoryModel(name: 'Accessories'),
      ];

      for (var category in categories) {
        await _db.insertCategory(category);
      }
      
      print('✓ Seed categories berhasil: ${categories.length} kategori');
    } else {
      print('✓ Categories sudah ada, skip seeding');
    }
  }

  // Seed products
  static Future<void> seedProducts() async {
    final existingProducts = await _db.getProducts();
    
    // Only seed if no products exist
    if (existingProducts.isEmpty) {
      final categories = await _db.getCategories();
      
      if (categories.isEmpty) {
        print('✗ Tidak ada kategori, seed categories terlebih dahulu');
        return;
      }

      // Get category IDs
      final tshirtId = categories.firstWhere((c) => c.name == 'T-Shirt').id!;
      final hoodieId = categories.firstWhere((c) => c.name == 'Hoodie').id!;
      final jacketId = categories.firstWhere((c) => c.name == 'Jacket').id!;
      final accessoriesId = categories.firstWhere((c) => c.name == 'Accessories').id!;

      final products = [
        // T-Shirts
        ProductModel(
          categoryId: tshirtId,
          name: 'Laviade Classic Black Tee',
          price: 250000,
          stock: 15,
          description: 'Classic black t-shirt dengan design minimalis Laviade. Material premium cotton 100%.',
          imageName: 'tshirt_black.png',
        ),
        ProductModel(
          categoryId: tshirtId,
          name: 'Laviade White Oversized Tee',
          price: 275000,
          stock: 12,
          description: 'Oversized white t-shirt dengan cutting modern. Nyaman untuk daily wear.',
          imageName: 'tshirt_white.png',
        ),
        
        // Hoodies
        ProductModel(
          categoryId: hoodieId,
          name: 'Laviade Black Hoodie',
          price: 450000,
          stock: 8,
          description: 'Premium black hoodie dengan embroidered logo. Material fleece berkualitas tinggi.',
          imageName: 'hoodie_black.png',
        ),
        ProductModel(
          categoryId: hoodieId,
          name: 'Laviade Gray Essential Hoodie',
          price: 425000,
          stock: 10,
          description: 'Essential gray hoodie dengan fit sempurna. Cocok untuk streetwear style.',
          imageName: 'hoodie_gray.png',
        ),
        
        // Jackets
        ProductModel(
          categoryId: jacketId,
          name: 'Laviade Denim Jacket',
          price: 650000,
          stock: 5,
          description: 'Classic denim jacket dengan Laviade patch. Premium denim material.',
          imageName: 'jacket_denim.png',
        ),
        ProductModel(
          categoryId: jacketId,
          name: 'Laviade Bomber Jacket',
          price: 750000,
          stock: 6,
          description: 'Modern bomber jacket dengan design edgy. Windproof dan water resistant.',
          imageName: 'jacket_bomber.png',
        ),
        
        // Accessories
        ProductModel(
          categoryId: accessoriesId,
          name: 'Laviade Black Cap',
          price: 150000,
          stock: 20,
          description: 'Snapback cap dengan embroidered Laviade logo. Adjustable size.',
          imageName: 'cap_black.png',
        ),
        ProductModel(
          categoryId: accessoriesId,
          name: 'Laviade Tote Bag',
          price: 200000,
          stock: 15,
          description: 'Canvas tote bag dengan printed Laviade branding. Spacious dan durable.',
          imageName: 'totebag.png',
        ),
      ];

      for (var product in products) {
        await _db.insertProduct(product);
      }
      
      print('✓ Seed products berhasil: ${products.length} produk');
    } else {
      print('✓ Products sudah ada, skip seeding');
    }
  }

  // Run all seeds
  static Future<void> runSeeds() async {
    print('=== Memulai Seed Data ===');
    
    try {
      await seedCategories();
      await seedProducts();
      print('=== Seed Data Selesai ===');
    } catch (e) {
      print('✗ Error saat seeding: $e');
    }
  }
}
