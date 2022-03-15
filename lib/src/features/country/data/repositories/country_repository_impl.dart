import 'package:covid_tracker/src/core/error/exceptions.dart';
import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/core/network/network_info.dart';
import 'package:covid_tracker/src/features/country/data/data_sources/country_local_data_source.dart';
import 'package:covid_tracker/src/features/country/data/data_sources/country_remote_data_source.dart';
import 'package:covid_tracker/src/features/country/domain/entities/country.dart';
import 'package:covid_tracker/src/features/country/domain/entities/country_stat.dart';
import 'package:covid_tracker/src/features/country/domain/repositories/country_repository.dart';
import 'package:fpdart/fpdart.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;
  final CountryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CountryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CountryStat>>> getCountryStat(String slug) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCountryStat = await remoteDataSource.getCountryStat(slug);
        localDataSource.cacheCountryStat(remoteCountryStat);
        return Right(remoteCountryStat);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCountryStat = await localDataSource.getLastCountryStat();
        return Right(localCountryStat);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Country>>> getCountryList() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCountryList = await remoteDataSource.getCountryList();
        localDataSource.cacheCountryList(remoteCountryList);
        return Right(remoteCountryList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCountryList = await localDataSource.getLastCountryList();
        return Right(localCountryList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
