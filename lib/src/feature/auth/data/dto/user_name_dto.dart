import 'package:json_annotation/json_annotation.dart';
import 'package:lanars/src/feature/auth/data/entity/user_name_entity.dart';

part 'user_name_dto.g.dart';

@JsonSerializable()
class UserNameDto extends UserNameEntity {
  const UserNameDto({
    required super.title,
    required super.first,
    required super.last,
  });

  factory UserNameDto.fromJson(Map<String, dynamic> json) => _$UserNameDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserNameDtoToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserNameEntity && other.title == title && other.first == first && other.last == last;
  }

  @override
  int get hashCode => title.hashCode ^ first.hashCode ^ last.hashCode;
}
