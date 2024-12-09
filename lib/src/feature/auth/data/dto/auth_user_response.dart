import 'package:json_annotation/json_annotation.dart';
import 'package:lanars/src/feature/auth/data/dto/user_dto.dart';

part 'auth_user_response.g.dart';

@JsonSerializable()
class AuthUserResponse {
  final List<AuthenticatedUserDTO> results;

  const AuthUserResponse({required this.results});

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) => _$AuthUserResponseFromJson(json);
}
