import 'package:equatable/equatable.dart';

class SportCategoryEntity extends Equatable {
  final int id;
  final String name;

  const SportCategoryEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() {
    return 'SportCategoryEntity(id: $id, name: $name)';
  }

  SportCategoryEntity copyWith({
    int? id,
    String? name,
  }) {
    return SportCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
