class CategoryModel {
  final int? id;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  CategoryModel({
    this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  // Convert Map to CategoryModel
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  // Convert CategoryModel to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
      'updated_at': updatedAt ?? DateTime.now().toIso8601String(),
    };
  }

  // Create copy with updated fields
  CategoryModel copyWith({
    int? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
