import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/core/use_case/use_case.dart';
import 'package:covid_tracker/src/features/country/domain/entities/country_stat.dart';
import 'package:covid_tracker/src/features/country/domain/repositories/country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class GetCountryStat implements UseCase<List<CountryStat>, Params> {
  final CountryRepository repository;

  GetCountryStat(this.repository);

  @override
  Future<Either<Failure, List<CountryStat>>> call(Params params) async {
    return await repository.getCountryStat(params.slug);
  }
}

class Params extends Equatable {
  final String slug;

  const Params({required this.slug});

  @override
  List<Object> get props => [slug];
}
