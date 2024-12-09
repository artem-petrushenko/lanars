import 'package:lanars/src/feature/auth/data/entity/user_entity.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';
@immutable
@JsonSerializable()
class AuthenticatedUserDTO extends AuthenticatedUserEntity {
  const AuthenticatedUserDTO({
    required super.gender,
  });

  @override
  String toString() => 'Authenticated user with gender: $gender';

  @override
  bool operator ==(final Object other) => other is AuthenticatedUserDTO;

  @override
  int get hashCode => gender.hashCode;

  factory AuthenticatedUserDTO.fromJson(Map<String, dynamic> json) => _$AuthenticatedUserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatedUserDTOToJson(this);
}

@immutable
class NotAuthenticatedUserDTO extends NotAuthenticatedUserEntity {
  @literal
  const NotAuthenticatedUserDTO();

  @override
  String toString() => 'User is not authenticated';

  @override
  bool operator ==(final Object other) => other is NotAuthenticatedUserDTO;

  @override
  int get hashCode => 0;
}
