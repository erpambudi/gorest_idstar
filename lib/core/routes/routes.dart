import 'package:flutter/material.dart';
import 'package:gorest_idstar/presentation/pages/user_detail_page.dart';
import 'package:gorest_idstar/presentation/pages/user_form_page.dart';
import 'package:gorest_idstar/presentation/pages/users_page.dart';

class AppRoutes {
  static MaterialPageRoute<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case UsersPage.routeName:
        return MaterialPageRoute(builder: (context) => const UsersPage());

      case UserDetailPage.routeName:
        return MaterialPageRoute(builder: (context) => UserDetailPage());

      case UserFormPage.routeName:
        return MaterialPageRoute(builder: (context) => UserFormPage());

      //Unknown page
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
  }
}
