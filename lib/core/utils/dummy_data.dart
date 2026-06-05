class DummyProduct {
  const DummyProduct({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.categoryName,
    required this.price,
    required this.stock,
    required this.description,
    required this.imageName,
  });

  final int id;
  final int categoryId;
  final String name;
  final String categoryName;
  final int price;
  final int stock;
  final String description;
  final String imageName;
}

class DummyCategory {
  const DummyCategory({
    required this.id,
    required this.name,
    this.isUsed = false,
  });

  final int id;
  final String name;
  final bool isUsed;
}

class DummyData {
  const DummyData._();

  static const categories = [
    DummyCategory(id: 0, name: 'All'),
    DummyCategory(id: 1, name: 'T-Shirt', isUsed: true),
    DummyCategory(id: 2, name: 'Hoodie', isUsed: true),
    DummyCategory(id: 3, name: 'Pants'),
  ];

  static const products = [
    DummyProduct(
      id: 1,
      categoryId: 2,
      name: 'Black Box Hoodie',
      categoryName: 'Hoodie',
      price: 329000,
      stock: 12,
      description:
          'Hoodie heavyweight dengan karakter streetwear minimal. Cocok untuk katalog lokal Laviade.',
      imageName: 'hoodie_black.png',
    ),
    DummyProduct(
      id: 2,
      categoryId: 1,
      name: 'Studio Logo Tee',
      categoryName: 'T-Shirt',
      price: 159000,
      stock: 20,
      description:
          'T-shirt basic dengan logo Laviade Studio dan potongan clean untuk daily wear.',
      imageName: 'tee_logo.png',
    ),
    DummyProduct(
      id: 3,
      categoryId: 3,
      name: 'Utility Cargo Pants',
      categoryName: 'Pants',
      price: 279000,
      stock: 7,
      description:
          'Cargo pants simple dengan detail utilitarian. Data ini dummy untuk static UI.',
      imageName: 'cargo_pants.png',
    ),
  ];
}
