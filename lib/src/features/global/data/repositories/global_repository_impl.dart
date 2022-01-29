import 'package:covid_tracker/src/core/error/exceptions.dart';
import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/core/network/network_info.dart';
import 'package:covid_tracker/src/features/global/data/data_sources/global_local_data_source.dart';
import 'package:covid_tracker/src/features/global/data/data_sources/global_remote_data_source.dart';
import 'package:covid_tracker/src/features/global/domain/entities/global_stat.dart';
import 'package:covid_tracker/src/features/global/domain/repositories/global_repository.dart';
import 'package:fpdart/fpdart.dart';

class GlobalRepositoryImpl implements GlobalRepository {
  final GlobalRemoteDataSource remoteDataSource;
  final GlobalLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GlobalRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, GlobalStat>> getGlobalStat() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGlobalStat = await remoteDataSource.getGlobalStat();
        localDataSource.cacheGlobalStat(remoteGlobalStat);
        return Right(remoteGlobalStat);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGlobalStat = await localDataSource.getLastGlobalStat();
        print(localGlobalStat);
        return Right(localGlobalStat);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
