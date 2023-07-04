import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'cubit/dashboard/dashboard_cubit.dart';
import 'repositories/dashboard_repository.dart';
import 'repositories_impl/dashboard_repository_impl.dart';
import 'cubit/login/login_cubit.dart';
import 'repositories/login_repository.dart';
import 'repositories_impl/login_repository_impl.dart';
import 'utils/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api_client.dart';
import 'api/remote_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Cubit
  if (!sl.isRegistered<LoginCubit>()) {
    sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  }

  if (!sl.isRegistered<DashboardCubit>()) {
    sl.registerLazySingleton<DashboardCubit>(() => DashboardCubit());
  }

  //repositories
  if (!sl.isRegistered<LoginRepository>()) {
    sl.registerLazySingleton(
      () => LoginRepositoryImpl(
        networkInfo: sl<NetworkInfoImpl>(),
        remoteDataSource: sl<RemoteDataSource>(),
      ),
    );
  }

  if (!sl.isRegistered<DashboardRepository>()) {
    sl.registerLazySingleton(
      () => DashboardRepositoryImpl(
        networkInfo: sl<NetworkInfoImpl>(),
        remoteDataSource: sl<RemoteDataSource>(),
      ),
    );
  }

  //Core
  if (!sl.isRegistered<GlobalKey<NavigatorState>>()) {
    sl.registerLazySingleton(() => GlobalKey<NavigatorState>());
  }

  if (!sl.isRegistered<ScreenUtil>()) {
    sl.registerLazySingleton(() => ScreenUtil());
  }

  if (!sl.isRegistered<ApiClient>()) {
    sl.registerLazySingleton(() => ApiClient());
  }

  final sharedPreferences = await SharedPreferences.getInstance();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }

  if (!sl.isRegistered<NetworkInfoImpl>()) {
    sl.registerLazySingleton(() => NetworkInfoImpl());
  }

  if (!sl.isRegistered<RemoteDataSource>()) {
    sl.registerLazySingleton(() => RemoteDataSource());
  }
}
