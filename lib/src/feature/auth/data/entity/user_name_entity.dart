import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserNameEntity {
  const UserNameEntity({
    required this.title,
    required this.first,
    required this.last,
  });

  final String title;
  final String first;
  final String last;

  String get fullName => '$title $first $last';
}
