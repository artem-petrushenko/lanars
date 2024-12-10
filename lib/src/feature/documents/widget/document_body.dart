import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars/src/feature/documents/bloc/document_bloc.dart';
import 'package:lanars/src/feature/documents/widget/document_cart.dart';
import 'package:lanars/src/feature/initialization/widget/dependencies_scope.dart';

class DocumentBody extends StatelessWidget {
  const DocumentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentBloc(
        documentRepository: DependenciesScope.of(context).documentRepository,
      )..add(const DocumentEvent.fetchPhotos()),
      child: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () {
              final completer = Completer();
              context.read<DocumentBloc>().add(DocumentEvent.fetchPhotos(completer: completer));
              return completer.future;
            },
            child: Scrollbar(
              child: CustomScrollView(
                slivers: [
                  if (state.isLoading && !state.hasData)
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (state.hasData)
                    SliverPadding(
                      padding: const EdgeInsets.all(16.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final photo = state.photos[index];
                            final currentLetter =
                                photo.photographer.isNotEmpty ? photo.photographer[0].toUpperCase() : '';
                            final previousLetter = index > 0 && state.photos[index - 1].photographer.isNotEmpty
                                ? state.photos[index - 1].photographer[0].toUpperCase()
                                : '';
                            return DocumentCart(
                              url: photo.src.original,
                              title: photo.photographer,
                              subtitle: photo.alt,
                              isShowLeather: currentLetter != previousLetter,
                            );
                          },
                          childCount: state.photos.length,
                        ),
                      ),
                    )
                  else if (!state.isLoading && !state.hasData)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Text('Empty'),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
