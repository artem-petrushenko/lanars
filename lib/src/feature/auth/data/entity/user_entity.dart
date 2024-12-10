import 'package:lanars/src/feature/auth/data/dto/picture_dto.dart';
import 'package:lanars/src/feature/auth/data/dto/user_name_dto.dart';

abstract class UserEntity {
  const UserEntity();

  bool get isAuthenticated;

  bool get isNotAuthenticated;

  factory UserEntity.notAuthenticated() => const NotAuthenticatedUserEntity();

  factory UserEntity.authenticated({
    required final String gender,
    required final String email,
    required final UserNameDto name,
    required final PictureDto picture,
  }) =>
      AuthenticatedUserEntity(
        gender: gender,
        email: email,
        name: name,
        picture: picture,
      );

  T when<T extends Object?>({
    required final T Function(AuthenticatedUserEntity user) authenticated,
    required final T Function() notAuthenticated,
  });
}

class AuthenticatedUserEntity extends UserEntity {
  const AuthenticatedUserEntity({
    required this.gender,
    required this.email,
    required this.name,
    required this.picture,
  });

  final String gender;
  final String email;
  //TODO: How in codegen use entity?
  final UserNameDto name;
  final PictureDto picture;

  @override
  bool get isAuthenticated => !isNotAuthenticated;

  @override
  bool get isNotAuthenticated => false;

  @override
  T when<T extends Object?>({
    required final T Function(AuthenticatedUserEntity user) authenticated,
    required final T Function() notAuthenticated,
  }) =>
      authenticated(this);
}

class NotAuthenticatedUserEntity extends UserEntity {
  const NotAuthenticatedUserEntity();

  @override
  bool get isAuthenticated => false;

  @override
  bool get isNotAuthenticated => true;

  @override
  T when<T extends Object?>({
    required final T Function(AuthenticatedUserEntity user) authenticated,
    required final T Function() notAuthenticated,
  }) =>
      notAuthenticated();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.isAuthenticated == isAuthenticated &&
        other.isNotAuthenticated == isNotAuthenticated;
  }

  @override
  int get hashCode => isAuthenticated.hashCode ^ isNotAuthenticated.hashCode;
}
