import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lanars/src/feature/settings/widget/text_scale/text_scale_widget.dart';
import 'package:lanars/src/feature/settings/widget/text_scale/theme_selector_widget.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const [
          TextScaleWidget(),
          ThemeSelectorWidget(),
        ],
      ),
    );
  }
}
