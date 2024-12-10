import 'package:json_annotation/json_annotation.dart';
import 'package:lanars/src/feature/documents/data/dto/document_dto.dart';

part 'document_response.g.dart';
@JsonSerializable()
class DocumentResponse {
  final List<DocumentDto> photos;

  const DocumentResponse({
    required this.photos,
  });

  factory DocumentResponse.fromJson(Map<String, dynamic> json) => _$DocumentResponseFromJson(json);
}
