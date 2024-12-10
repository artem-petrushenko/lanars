import 'package:json_annotation/json_annotation.dart';
import 'package:lanars/src/feature/documents/data/dto/image_dto.dart';
import 'package:lanars/src/feature/documents/data/entity/document_entity.dart';

part 'document_dto.g.dart';

@JsonSerializable()
class DocumentDto extends DocumentEntity {
  const DocumentDto({
    required super.id,
    required super.photographer,
    required super.src,
    required super.alt,
  });

  factory DocumentDto.fromJson(Map<String, dynamic> json) => _$DocumentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentDtoToJson(this);
}
