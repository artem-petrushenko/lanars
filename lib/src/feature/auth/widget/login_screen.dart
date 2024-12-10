import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars/src/common/widget/text/default_text.dart';
import 'package:lanars/src/core/routes/app_router.dart';
import 'package:lanars/src/feature/auth/bloc/auth_bloc.dart';
import 'package:lanars/src/feature/auth/widget/auth_scope.dart';
import 'package:lanars/src/feature/auth/widget/login_form.dart';
import 'package:lanars/src/feature/initialization/widget/dependencies_scope.dart';

/// {@template login_screen}
/// LoginScreen widget
/// {@endtemplate}
@RoutePage()
class LoginScreen extends StatefulWidget {
  /// {@macro login_screen}
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: DependenciesScope.of(context).authBloc,
      listener: (context, AuthState state) {
        if (state.user.isAuthenticated) {
          context.replaceRoute(const DocumentRoute());
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Server error. Please, try again'),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 72.0),
                child: DefaultText.headlineLarge(
                  'Sign in',
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              LoginForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                enable: !DependenciesScope.of(context).authBloc.state.isLoading,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      AuthScope.of(context).signInWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                      );
                    }
                  },
                  child: DependenciesScope.of(context).authBloc.state.isLoading
                      ? SizedBox.square(
                          dimension: 24.0,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : const Text('Sign in'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
