import 'package:dio/dio.dart';
import 'package:lanars/src/core/utils/rest_api/base_rest_api.dart';
import 'package:lanars/src/feature/auth/data/dto/auth_user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_data_source.g.dart';

/// Data source for authentication
@RestApi(baseUrl: BaseRestApi.authBaseUrl)
abstract interface class AuthDataSource {
  factory AuthDataSource(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AuthDataSource;

  @GET('/')
  Future<AuthUserResponse> signInWithEmailAndPassword({
    @Body() required Map<String, dynamic> data,
  });
}
