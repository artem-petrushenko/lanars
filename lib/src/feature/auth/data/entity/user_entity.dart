abstract class UserEntity {
  const UserEntity();

  bool get isAuthenticated;

  bool get isNotAuthenticated;

  factory UserEntity.notAuthenticated() => const NotAuthenticatedUserEntity();

  factory UserEntity.authenticated({
    required final String id,
  }) =>
      AuthenticatedUserEntity(id: id);

  T when<T extends Object?>({
    required final T Function(AuthenticatedUserEntity user) authenticated,
    required final T Function() notAuthenticated,
  });
}

class AuthenticatedUserEntity extends UserEntity {
  const AuthenticatedUserEntity({
    required this.id,
  });

  final String id;

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

  //TODO: Update the == operator and hashCode
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
