import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:lanars/src/core/routes/app_router.dart';
import 'package:lanars/src/feature/auth/logic/auth_interceptor.dart';
import 'package:lanars/src/feature/initialization/widget/dependencies_scope.dart';

class AuthGuard extends AutoRouteGuard {
  const AuthGuard({
    required this.context,
  });

  final BuildContext context;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuth = DependenciesScope.of(context).authBloc.state.status;
    if (isAuth == AuthenticationStatus.authenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
