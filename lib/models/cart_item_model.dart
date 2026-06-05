class CartItemModel {
  final int? id;
  final int productId;
  final int quantity;
  final String? createdAt;
  final String? updatedAt;

  // Optional fields for joining with product
  final String? productName;
  final int? productPrice;
  final String? productImageName;

  CartItemModel({
    this.id,
    required this.productId,
    required this.quantity,
    this.createdAt,
    this.updatedAt,
    this.productName,
    this.productPrice,
    this.productImageName,
  });

  // Convert Map to CartItemModel
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as int?,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      productName: map['product_name'] as String?,
      productPrice: map['product_price'] as int?,
      productImageName: map['product_image_name'] as String?,
    );
  }

  // Convert CartItemModel to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
      'updated_at': updatedAt ?? DateTime.now().toIso8601String(),
    };
  }

  // Calculate subtotal
  int getSubtotal() {
    if (productPrice != null) {
      return productPrice! * quantity;
    }
    return 0;
  }

  // Create copy with updated fields
  CartItemModel copyWith({
    int? id,
    int? productId,
    int? quantity,
    String? createdAt,
    String? updatedAt,
    String? productName,
    int? productPrice,
    String? productImageName,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productImageName: productImageName ?? this.productImageName,
    );
  }

  @override
  String toString() {
    return 'CartItemModel(id: $id, productId: $productId, quantity: $quantity, productName: $productName, subtotal: ${getSubtotal()})';
  }
}
