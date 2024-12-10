import 'package:flutter/material.dart';
import 'package:lanars/src/feature/documents/widget/log_out_button.dart';
import 'package:lanars/src/feature/settings/widget/settings_scope.dart';

class DrawerButtons extends StatelessWidget {
  const DrawerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LogOutButton(),
        IconButton(
          onPressed: () {
            final newTheme =
            SettingsScope.of(context).theme.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
            SettingsScope.of(context).setThemeMode(newTheme);
          },
          icon: Icon(
            SettingsScope.of(context).theme.mode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
          ),
        ),
      ],
    );
  }
}
