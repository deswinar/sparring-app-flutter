import 'package:equatable/equatable.dart';

class ProvinceEntity extends Equatable {
  final int id;
  final String name;
  final String abbreviation;

  const ProvinceEntity({
    required this.id,
    required this.name,
    required this.abbreviation,
  });

  @override
  List<Object?> get props => [id, name, abbreviation];

  @override
  String toString() {
    return 'ProvinceEntity(id: $id, name: $name, abbreviation: $abbreviation)';
  }

  ProvinceEntity copyWith({
    int? id,
    String? name,
    String? abbreviation,
  }) {
    return ProvinceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      abbreviation: abbreviation ?? this.abbreviation,
    );
  }
}
