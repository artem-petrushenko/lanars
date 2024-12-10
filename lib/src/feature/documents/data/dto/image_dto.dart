import 'package:json_annotation/json_annotation.dart';
import 'package:lanars/src/feature/documents/data/entity/image_entity.dart';

part 'image_dto.g.dart';

@JsonSerializable()
class ImageDto extends ImageEntity {
  const ImageDto({required super.original});

  factory ImageDto.fromJson(Map<String, dynamic> json) => _$ImageDtoFromJson(json);
}
