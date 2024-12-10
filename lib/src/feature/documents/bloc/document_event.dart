part of 'document_bloc.dart';

sealed class DocumentEvent {
  const DocumentEvent();

  /// Event to fetch photos
  const factory DocumentEvent.fetchPhotos({
    Completer? completer,
  }) = _FetchPhotos;
}

final class _FetchPhotos extends DocumentEvent {
  const _FetchPhotos({
    this.completer,
  });

  final Completer? completer;
}
