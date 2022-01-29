import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/features/global/domain/entities/global_stat.dart';
import 'package:fpdart/fpdart.dart';

abstract class GlobalRepository {
  Future<Either<Failure, GlobalStat>> getGlobalStat();
}
