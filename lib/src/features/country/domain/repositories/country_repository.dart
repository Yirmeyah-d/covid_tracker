import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/features/country/domain/entities/country.dart';
import 'package:covid_tracker/src/features/country/domain/entities/country_stat.dart';
import 'package:fpdart/fpdart.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<CountryStat>>> getCountryStat(String slug);
  Future<Either<Failure, List<Country>>> getCountryList();
}
