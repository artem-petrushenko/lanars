import 'package:auto_route/auto_route.dart';
import 'package:lanars/src/core/routes/auth_guard.dart';
import 'package:lanars/src/feature/auth/widget/login_screen.dart';
import 'package:lanars/src/feature/documents/widget/document_screen.dart';
import 'package:lanars/src/feature/settings/widget/settings_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/document',
          page: DocumentRoute.page,
          initial: true,
          guards: [
            AuthGuard(),
          ],
          children: [
            AutoRoute(path: 'settings', page: SettingsRoute.page),
          ],
        ),
        AutoRoute(path: '/login', page: LoginRoute.page),
      ];
}
