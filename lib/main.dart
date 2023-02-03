import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gorest_idstar/presentation/pages/users_page.dart';

import 'common/styles/app_theme.dart';
import 'core/routes/navigation_service.dart';
import 'core/routes/routes.dart';

import 'flavors/environment.dart';
import 'injection.dart' as di;
import 'presentation/bloc/user/user_detail_bloc.dart';
import 'presentation/bloc/user/user_manage_bloc.dart';
import 'presentation/bloc/user/users_bloc.dart';

void main() {
  di.init();

  env(Environment.development);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<UsersBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<UserDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<UserManageBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GoREST',
        theme: AppTheme.light(),
        home: const UsersPage(),
        navigatorKey: di.locator<NavigationService>().navigatorKey,
        onGenerateRoute: ((settings) {
          return AppRoutes.routes(settings);
        }),
      ),
    );
  }
}
