class WishlistItemModel {
  final int? id;
  final int productId;
  final String createdAt;

  WishlistItemModel({this.id, required this.productId, String? createdAt})
    : createdAt = createdAt ?? DateTime.now().toIso8601String();

  factory WishlistItemModel.fromMap(Map<String, dynamic> map) {
    return WishlistItemModel(
      id: map['id'] as int?,
      productId: map['product_id'] as int,
      createdAt: map['created_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'product_id': productId, 'created_at': createdAt};
  }

  WishlistItemModel copyWith({int? id, int? productId, String? createdAt}) {
    return WishlistItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
