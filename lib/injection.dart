import 'package:get_it/get_it.dart';

import 'core/routes/navigation_service.dart';
import 'data/datasources/preferences/preference_manager.dart';
import 'data/datasources/preferences/preference_manager_impl.dart';
import 'data/datasources/remote/users_remote.dart';
import 'data/repositories/user_repository.dart';
import 'presentation/bloc/user/user_detail_bloc.dart';
import 'presentation/bloc/user/user_manage_bloc.dart';
import 'presentation/bloc/user/users_bloc.dart';

final locator = GetIt.instance;

void init() {
  // BloC
  locator.registerLazySingleton<UsersBloc>(() => UsersBloc(locator()));
  locator
      .registerLazySingleton<UserDetailBloc>(() => UserDetailBloc(locator()));
  locator
      .registerLazySingleton<UserManageBloc>(() => UserManageBloc(locator()));

  // Datasources
  locator.registerLazySingleton<UsersRemote>(() => UsersRemoteImpl());

  // Repository
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(locator()));

  // Navigation
  locator.registerLazySingleton(() => NavigationService());

  // Local DB
  locator
      .registerLazySingleton<PreferenceManager>(() => PreferenceManagerImpl());
}
