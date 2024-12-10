import 'package:json_annotation/json_annotation.dart';
import 'package:lanars/src/feature/auth/data/entity/picture_entity.dart';

part 'picture_dto.g.dart';

@JsonSerializable()
class PictureDto extends PictureEntity {
  const PictureDto({
    required super.large,
    required super.medium,
    required super.thumbnail,
  });

  factory PictureDto.fromJson(Map<String, dynamic> json) => _$PictureDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PictureDtoToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PictureEntity && other.large == large && other.medium == medium && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => large.hashCode ^ medium.hashCode ^ thumbnail.hashCode;
}
