import 'package:lanars/src/feature/documents/data/dto/image_dto.dart';

class DocumentEntity {
  const DocumentEntity({
    required this.id,
    required this.photographer,
    required this.src,
    required this.alt,
  });

  final int id;
  final String photographer;
  final ImageDto src;
  final String alt;
}
