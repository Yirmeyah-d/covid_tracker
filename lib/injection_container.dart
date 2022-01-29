import 'package:covid_tracker/src/core/network/network_info.dart';
import 'package:covid_tracker/src/features/global/data/data_sources/global_local_data_source.dart';
import 'package:covid_tracker/src/features/global/data/data_sources/global_remote_data_source.dart';
import 'package:covid_tracker/src/features/global/data/repositories/global_repository_impl.dart';
import 'package:covid_tracker/src/features/global/domain/repositories/global_repository.dart';
import 'package:covid_tracker/src/features/global/domain/use_cases/get_global_stat.dart';
import 'package:covid_tracker/src/features/global/presentation/bloc/global_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final serviceLocator = GetIt.instance;
Future<void> init() async {
  //! Features - NumberTrivia
  //Bloc
  serviceLocator.registerFactory(
    () => GlobalBloc(
      getGlobalStat: serviceLocator(),
    ),
  );
  // Use cases
  serviceLocator.registerLazySingleton(() => GetGlobalStat(serviceLocator()));
  // Repository
  serviceLocator.registerLazySingleton<GlobalRepository>(
    () => GlobalRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  // Data Sources
  serviceLocator.registerLazySingleton<GlobalRemoteDataSource>(
    () => GlobalRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GlobalLocalDataSource>(
    () => GlobalLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  //! Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      serviceLocator(),
    ),
  );

  //! External
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
