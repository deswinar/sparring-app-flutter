import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String name;
  final String email;

  const UserEntity({
    this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];

  @override
  String toString() => 'UserEntity(id: $id, name: $name, email: $email)';

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
