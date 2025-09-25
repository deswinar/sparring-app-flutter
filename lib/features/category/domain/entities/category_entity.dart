import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;

  const CategoryEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() {
    return 'CategoryEntity(id: $id, name: $name)';
  }

  CategoryEntity copyWith({
    int? id,
    String? name,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
