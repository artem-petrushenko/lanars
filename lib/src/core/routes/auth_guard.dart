import 'package:auto_route/auto_route.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (true) {
      //   if user is authenticated we continue
      resolver.next(true);
    }
    // } else {
    //   we redirect the user to our login page
    //   tip: use resolver.redirect to have the redirected route
    //   automatically removed from the stack when the resolver is completed
    // resolver.redirect(
    //     LoginRoute(onResult: (success) {
    //       if success == true the navigation will be resumed
    //       else it will be aborted
    // resolver.next(success);
    // },
    // );
    // );
    // }
  }
}
