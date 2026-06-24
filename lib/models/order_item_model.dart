class OrderItemModel {
  final int? id;
  final int orderId;
  final int productId;
  final String productNameSnapshot;
  final double productPriceSnapshot;
  final int quantity;
  final double subtotal;

  OrderItemModel({
    this.id,
    required this.orderId,
    required this.productId,
    required this.productNameSnapshot,
    required this.productPriceSnapshot,
    required this.quantity,
    required this.subtotal,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as int?,
      orderId: map['order_id'] as int,
      productId: map['product_id'] as int,
      productNameSnapshot: map['product_name_snapshot'] as String,
      productPriceSnapshot: (map['product_price_snapshot'] as num).toDouble(),
      quantity: map['quantity'] as int,
      subtotal: (map['subtotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'product_name_snapshot': productNameSnapshot,
      'product_price_snapshot': productPriceSnapshot,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }

  OrderItemModel copyWith({
    int? id,
    int? orderId,
    int? productId,
    String? productNameSnapshot,
    double? productPriceSnapshot,
    int? quantity,
    double? subtotal,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productNameSnapshot: productNameSnapshot ?? this.productNameSnapshot,
      productPriceSnapshot: productPriceSnapshot ?? this.productPriceSnapshot,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
    );
  }
}
