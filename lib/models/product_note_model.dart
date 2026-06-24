class ProductNoteModel {
  final int? id;
  final int productId;
  final String? title;
  final String note;
  final String createdAt;
  final String updatedAt;

  ProductNoteModel({
    this.id,
    required this.productId,
    this.title,
    required this.note,
    String? createdAt,
    String? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now().toIso8601String(),
       updatedAt = updatedAt ?? DateTime.now().toIso8601String();

  factory ProductNoteModel.fromMap(Map<String, dynamic> map) {
    return ProductNoteModel(
      id: map['id'] as int?,
      productId: map['product_id'] as int,
      title: map['title'] as String?,
      note: map['note'] as String,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'title': title,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  ProductNoteModel copyWith({
    int? id,
    int? productId,
    String? title,
    String? note,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProductNoteModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
