import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lanars/src/feature/documents/data/entity/document_entity.dart';
import 'package:lanars/src/feature/documents/data/repository/document_repository.dart';

part 'document_event.dart';

part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc({
    required DocumentRepository documentRepository,
  })  : _documentRepository = documentRepository,
        super(const DocumentState.idle(photos: [])) {
    on<DocumentEvent>(
      (event, emit) => switch (event) {
        final _FetchPhotos e => _onFetchPhotos(e, emit),
      },
    );
  }

  final DocumentRepository _documentRepository;

  bool _hasReachedMax = false;
  int _page = 1;
  final int _pageSize = 50;

  void _resetPage() {
    _page = 1;
    _hasReachedMax = false;
  }

  void _checkMax(int length) {
    if (length < _pageSize) {
      _hasReachedMax = true;
    } else {
      _page++;
    }
  }

  Future<void> _onFetchPhotos(
    _FetchPhotos event,
    Emitter<DocumentState> emit,
  ) async {
    if (state.isLoading) {
      event.completer?.complete();
      return;
    }
    _resetPage();
    emit(DocumentState.processing(photos: state.photos));
    try {
      final photos = await _documentRepository.getCuratedDocuments(
        _page,
        _pageSize,
      );
      _checkMax(photos.length);
      final sortByName = photos..sort((a, b) => a.photographer.compareTo(b.photographer));
      emit(DocumentState.idle(photos: sortByName));
    } on Object catch (error, stackTrace) {
      emit(DocumentState.failure(
        photos: state.photos,
        error: error,
      ));
      onError(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }
}
