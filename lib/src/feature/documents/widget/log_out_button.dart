import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars/src/core/routes/app_router.dart';
import 'package:lanars/src/feature/auth/bloc/auth_bloc.dart';
import 'package:lanars/src/feature/auth/widget/auth_scope.dart';
import 'package:lanars/src/feature/initialization/widget/dependencies_scope.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: DependenciesScope.of(context).authBloc,
      listener: (context, state) {
        if (state.user.isNotAuthenticated) {
          Navigator.of(context).pop();
          context.replaceRoute(const LoginRoute());
        }
      },
      child: TextButton.icon(
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
        icon: Icon(
          Icons.logout,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        label: Text(
          'Log out',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
