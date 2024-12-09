import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanars/src/core/routes/app_router.dart';
import 'package:lanars/src/feature/documents/widget/document_drawer.dart';
import 'package:lanars/src/feature/settings/widget/settings_scope.dart';

@RoutePage()
class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
      body: const Center(
        child: Text('DocumentScreen'),
      ),
    );
  }
}
