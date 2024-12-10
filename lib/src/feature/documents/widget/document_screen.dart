import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanars/src/feature/documents/widget/document_body.dart';
import 'package:lanars/src/feature/documents/widget/document_drawer.dart';

@RoutePage()
class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DocumentDrawer(),
      ),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          );
        }),
        title: const Text('List page'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const DocumentBody(),
    );
  }
}
