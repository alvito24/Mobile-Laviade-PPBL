class ProductModel {
  final int? id;
  final int categoryId;
  final String name;
  final int price;
  final int stock;
  final String? description;
  final String? imageName;
  final String? createdAt;
  final String? updatedAt;

  // Optional field for joining with category
  final String? categoryName;

  ProductModel({
    this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.stock,
    this.description,
    this.imageName,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
  });

  // Convert Map to ProductModel
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int?,
      categoryId: map['category_id'] as int,
      name: map['name'] as String,
      price: map['price'] as int,
      stock: map['stock'] as int,
      description: map['description'] as String?,
      imageName: map['image_name'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      categoryName: map['category_name'] as String?,
    );
  }

  // Convert ProductModel to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'price': price,
      'stock': stock,
      'description': description,
      'image_name': imageName,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
      'updated_at': updatedAt ?? DateTime.now().toIso8601String(),
    };
  }

  // Create copy with updated fields
  ProductModel copyWith({
    int? id,
    int? categoryId,
    String? name,
    int? price,
    int? stock,
    String? description,
    String? imageName,
    String? createdAt,
    String? updatedAt,
    String? categoryName,
  }) {
    return ProductModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      description: description ?? this.description,
      imageName: imageName ?? this.imageName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, categoryId: $categoryId, name: $name, price: $price, stock: $stock, categoryName: $categoryName)';
  }
}
