class OrderSimulationModel {
  final int? id;
  final String orderCode;
  final String createdAt;
  final String status;
  final double totalAmount;
  final int totalItems;
  final String? note;

  OrderSimulationModel({
    this.id,
    required this.orderCode,
    required this.createdAt,
    required this.status,
    required this.totalAmount,
    required this.totalItems,
    this.note,
  });

  factory OrderSimulationModel.fromMap(Map<String, dynamic> map) {
    return OrderSimulationModel(
      id: map['id'] as int?,
      orderCode: map['order_code'] as String,
      createdAt: map['created_at'] as String,
      status: map['status'] as String,
      totalAmount: (map['total_amount'] as num).toDouble(),
      totalItems: map['total_items'] as int,
      note: map['note'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_code': orderCode,
      'created_at': createdAt,
      'status': status,
      'total_amount': totalAmount,
      'total_items': totalItems,
      'note': note,
    };
  }

  OrderSimulationModel copyWith({
    int? id,
    String? orderCode,
    String? createdAt,
    String? status,
    double? totalAmount,
    int? totalItems,
    String? note,
  }) {
    return OrderSimulationModel(
      id: id ?? this.id,
      orderCode: orderCode ?? this.orderCode,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      totalItems: totalItems ?? this.totalItems,
      note: note ?? this.note,
    );
  }
}
