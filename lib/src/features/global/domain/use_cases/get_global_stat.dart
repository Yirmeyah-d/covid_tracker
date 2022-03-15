import 'package:fpdart/fpdart.dart';
import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/core/use_case/use_case.dart';
import 'package:covid_tracker/src/features/global/domain/entities/global_stat.dart';
import 'package:covid_tracker/src/features/global/domain/repositories/global_repository.dart';

class GetGlobalStat implements UseCase<GlobalStat, NoParams> {
  final GlobalRepository repository;

  GetGlobalStat(this.repository);

  @override
  Future<Either<Failure, GlobalStat>> call(NoParams params) async {
    return await repository.getGlobalStat();
  }
}
