import 'package:lanars/src/feature/auth/data/dto/picture_dto.dart';
import 'package:lanars/src/feature/auth/data/dto/user_name_dto.dart';
import 'package:lanars/src/feature/auth/data/entity/user_entity.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@immutable
@JsonSerializable()
class AuthenticatedUserDTO extends AuthenticatedUserEntity {
  const AuthenticatedUserDTO({
    required super.gender,
    required super.email,
    required super.name,
    required super.picture,
  });

  @override
  String toString() => 'Authenticated user with gender: $gender';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthenticatedUserEntity &&
        other.isAuthenticated == isAuthenticated &&
        other.isNotAuthenticated == isNotAuthenticated &&
        other.email == email &&
        other.gender == gender &&
        other.name == name &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return isAuthenticated.hashCode ^
        isNotAuthenticated.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        name.hashCode ^
        picture.hashCode;
  }

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
