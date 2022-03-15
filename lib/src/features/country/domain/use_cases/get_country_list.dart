import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/core/use_case/use_case.dart';
import 'package:covid_tracker/src/features/country/domain/entities/country.dart';
import 'package:covid_tracker/src/features/country/domain/repositories/country_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCountryList implements UseCase<List<Country>, NoParams> {
  final CountryRepository repository;

  GetCountryList(this.repository);

  @override
  Future<Either<Failure, List<Country>>> call(NoParams params) async {
    return await repository.getCountryList();
  }
}
