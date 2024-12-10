part of 'document_bloc.dart';

sealed class DocumentState {
  const DocumentState({required this.photos});

  final List<DocumentEntity> photos;

  const factory DocumentState.idle({
    required List<DocumentEntity> photos,
  }) = _DocumentStateIdle;

  const factory DocumentState.processing({
    required List<DocumentEntity> photos,
  }) = _DocumentStateProcessing;

  const factory DocumentState.failure({
    required List<DocumentEntity> photos,
    required Object error,
  }) = _DocumentStateFailure;

  Object? get error => switch (this) {
        final _DocumentStateFailure e => e.error,
        _ => null,
      };

  bool get hasData => photos.isNotEmpty;

  bool get isLoading => this is _DocumentStateProcessing;
}

final class _DocumentStateIdle extends DocumentState {
  const _DocumentStateIdle({required super.photos});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _DocumentStateIdle && other.photos == photos;
  }

  @override
  int get hashCode => Object.hashAll([photos]);

  @override
  String toString() => '_DocumentStateIdle(photos: $photos)';
}

final class _DocumentStateProcessing extends DocumentState {
  const _DocumentStateProcessing({required super.photos});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _DocumentStateProcessing && other.photos == photos;
  }

  @override
  int get hashCode => Object.hashAll([photos]);

  @override
  String toString() => '_DocumentStateProcessing(photos: $photos)';
}

final class _DocumentStateFailure extends DocumentState {
  @override
  final Object error;

  const _DocumentStateFailure({
    required this.error,
    required super.photos,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _DocumentStateFailure && other.photos == photos && other.error == error;
  }

  @override
  int get hashCode => Object.hashAll([photos, error]);

  @override
  String toString() => '_DocumentStateFailure(photos: $photos, error: $error)';
}
