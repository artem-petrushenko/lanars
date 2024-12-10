import 'dart:async';
import 'dart:convert';

import 'package:lanars/src/core/utils/preferences_dao.dart';
import 'package:lanars/src/feature/auth/data/dto/user_dto.dart';
import 'package:lanars/src/feature/auth/data/entity/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class UserStorage {
  Future<UserEntity> load();

  Future<void> save(AuthenticatedUserEntity user);

  Future<void> clear();
}

final class UserStorageSP implements UserStorage {
  /// {@macro token_storage_sp}
  UserStorageSP({required SharedPreferences sharedPreferences})
      : _user = TypedEntry(
          sharedPreferences: sharedPreferences,
          key: 'user',
        );

  late final PreferencesEntry<String> _user;

  @override
  Future<UserEntity> load() async {
    final user = _user.read();

    if (user == null) {
      return UserEntity.notAuthenticated();
    }
    final json = jsonDecode(user);
    return AuthenticatedUserDTO.fromJson(json);
  }

  @override
  Future<void> save(AuthenticatedUserEntity user) async {
    final json = jsonEncode((user as AuthenticatedUserDTO).toJson());
    await _user.set(json);
  }

  @override
  Future<void> clear() async {
    await _user.remove();
  }
}
