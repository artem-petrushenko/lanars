import 'package:flutter/material.dart';
import 'package:lanars/src/feature/settings/widget/settings_scope.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final textScale = SettingsScope.textScaleOf(context).textScale;

    final mediaQueryData = MediaQuery.of(context);

    return MaterialApp(
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.mode,
      builder: (context, child) => MediaQuery(
        key: _globalKey,
        data: mediaQueryData.copyWith(
          textScaler: TextScaler.linear(
            mediaQueryData.textScaler.scale(textScale).clamp(0.5, 2),
          ),
        ),
        child: child!,
      ),
    );
  }
}
