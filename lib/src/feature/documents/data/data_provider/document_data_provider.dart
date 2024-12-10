import 'package:dio/dio.dart';
import 'package:lanars/src/core/utils/rest_api/base_rest_api.dart';
import 'package:lanars/src/feature/documents/data/dto/document_response.dart';
import 'package:retrofit/retrofit.dart';

part 'document_data_provider.g.dart';
/// Data source for authentication
@RestApi(baseUrl: BaseRestApi.baseUrl)
abstract interface class DocumentDataSource {
  factory DocumentDataSource(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _DocumentDataSource;

  @GET('/curated')
  Future<DocumentResponse> fetchPhotos({
    @Query('page') required int page,
    @Query('per_page') required int perPage,
  });
}
