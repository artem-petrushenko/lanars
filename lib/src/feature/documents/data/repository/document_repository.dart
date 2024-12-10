import 'package:lanars/src/feature/documents/data/data_provider/document_data_provider.dart';
import 'package:lanars/src/feature/documents/data/entity/document_entity.dart';

/// DocumentRepository
abstract interface class DocumentRepository {
  Future<List<DocumentEntity>> getCuratedDocuments(
    int page,
    int perPage,
  );
}

/// DocumentRepositoryImpl
final class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentDataSource _dataSource;

  /// Create an [AuthRepositoryImpl]
  const DocumentRepositoryImpl({
    required DocumentDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<List<DocumentEntity>> getCuratedDocuments(int page, int perPage) {
    return _dataSource.fetchPhotos(page: page, perPage: perPage).then((response) => response.photos);
  }
}
