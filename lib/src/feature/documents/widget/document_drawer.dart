import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lanars/src/feature/auth/widget/auth_scope.dart';
import 'package:lanars/src/feature/settings/widget/settings_scope.dart';

class DocumentDrawer extends StatelessWidget {
  const DocumentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Log out'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          AuthScope.of(context).signOut();
                        },
                        child: const Text('Log out'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
          ),
          IconButton(
            onPressed: () {
              final newTheme =
                  SettingsScope.of(context).theme.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
              SettingsScope.of(context).setThemeMode(newTheme);
            },
            icon: Icon(
              SettingsScope.of(context).theme.mode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
            ),
          )
        ],
      ),
    );
  }
}
