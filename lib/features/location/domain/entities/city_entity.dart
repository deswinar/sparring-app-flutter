import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final int id;
  final int provinceId;
  final String name;
  final String type;

  const CityEntity({
    required this.id,
    required this.provinceId,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [id, provinceId, name, type];

  @override
  String toString() {
    return 'CityEntity(id: $id, provinceId: $provinceId, name: $name, type: $type)';
  }

  CityEntity copyWith({
    int? id,
    int? provinceId,
    String? name,
    String? type,
  }) {
    return CityEntity(
      id: id ?? this.id,
      provinceId: provinceId ?? this.provinceId,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}
