import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rent_ready_task/core/network/api/http_api.dart';
import 'package:rent_ready_task/feature/data/datasources/account_local_datsource.dart';
import 'package:rent_ready_task/feature/data/datasources/account_remote_datasource.dart';
import 'package:rent_ready_task/feature/data/repositories/account_repositories_impl.dart';
import 'package:rent_ready_task/feature/domain/repositories/account_repository.dart';
import 'package:rent_ready_task/feature/domain/usecases/get_accounts.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Account list
  // Bloc
  sl.registerFactory(
    () => AccountListBloc(
      getAccounts: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAccounts(sl()));

  // Repository
  sl.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AccountRemoteDataSource>(
    () => AccountRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<AccountLocalDataSource>(
    () => AccountLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => HttpApi());
  sl.registerLazySingleton(() => DataConnectionChecker());

}
