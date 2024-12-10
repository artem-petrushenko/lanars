import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lanars/src/feature/documents/widget/drawer_buttons.dart';
import 'package:lanars/src/feature/documents/widget/drawer_profile.dart';

class DocumentDrawer extends StatelessWidget {
  const DocumentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawerProfile(),
            DrawerButtons(),
          ],
        ),
      ),
    );
  }
}
