import 'package:covid_tracker/src/core/network/network_info.dart';
import 'package:covid_tracker/src/features/country/data/data_sources/country_local_data_source.dart';
import 'package:covid_tracker/src/features/country/data/data_sources/country_remote_data_source.dart';
import 'package:covid_tracker/src/features/country/data/repositories/country_repository_impl.dart';
import 'package:covid_tracker/src/features/country/domain/repositories/country_repository.dart';
import 'package:covid_tracker/src/features/country/domain/use_cases/get_country_list.dart';
import 'package:covid_tracker/src/features/country/domain/use_cases/get_country_stat.dart';
import 'package:covid_tracker/src/features/country/presentation/bloc/country_bloc.dart';
import 'package:covid_tracker/src/features/global/data/data_sources/global_local_data_source.dart';
import 'package:covid_tracker/src/features/global/data/data_sources/global_remote_data_source.dart';
import 'package:covid_tracker/src/features/global/data/repositories/global_repository_impl.dart';
import 'package:covid_tracker/src/features/global/domain/repositories/global_repository.dart';
import 'package:covid_tracker/src/features/global/domain/use_cases/get_global_stat.dart';
import 'package:covid_tracker/src/features/global/presentation/bloc/global_bloc.dart';
import 'package:covid_tracker/src/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:covid_tracker/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:covid_tracker/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:covid_tracker/src/features/settings/domain/use_cases/load_theme_mode.dart';
import 'package:covid_tracker/src/features/settings/domain/use_cases/update_theme_mode.dart';
import 'package:covid_tracker/src/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final serviceLocator = GetIt.instance;
Future<void> init() async {
  //! Features - Global
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

  //! Features - Country
  //Bloc
  serviceLocator.registerFactory(
    () => CountryBloc(
      getCountryStat: serviceLocator(),
      getCountryList: serviceLocator(),
    ),
  );
  // Use cases
  serviceLocator.registerLazySingleton(() => GetCountryStat(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCountryList(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  // Data Sources
  serviceLocator.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<CountryLocalDataSource>(
    () => CountryLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  //! Features - Settings
  //Bloc
  serviceLocator.registerFactory(
    () => SettingsBloc(
      loadThemeMode: serviceLocator(),
      updateThemeMode: serviceLocator(),
    ),
  );
  // Use cases
  serviceLocator.registerLazySingleton(() => UpdateThemeMode(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LoadThemeMode(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: serviceLocator(),
    ),
  );
  // Data Sources
  serviceLocator.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(
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
