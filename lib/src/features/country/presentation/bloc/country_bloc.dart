import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/core/use_case/use_case.dart';
import 'package:covid_tracker/src/core/utils/failure_api.dart';
import 'package:covid_tracker/src/features/country/domain/entities/country.dart';
import 'package:covid_tracker/src/features/country/domain/entities/country_stat.dart';
import 'package:covid_tracker/src/features/country/domain/use_cases/get_country_list.dart';
import 'package:covid_tracker/src/features/country/domain/use_cases/get_country_stat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
part 'country_state.dart';
part 'country_event.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final GetCountryStat getCountryStat;
  final GetCountryList getCountryList;

  CountryBloc({
    required this.getCountryStat,
    required this.getCountryList,
  }) : super(CountryInitial()) {
    on<GetCountryStatEvent>(_onGetCountry);
  }

  void _eitherLoadedAfterGetCountryOrErrorState(
    Either<Failure, List<CountryStat>> failureOrCountryStat,
    Either<Failure, List<Country>> failureOrCountryList,
    Emitter<CountryState> emit,
  ) {
    failureOrCountryList.fold(
      (failure) => emit(
        CountryError(
          message: failure.mapFailureToMessage,
        ),
      ),
      (countryList) => failureOrCountryStat.fold(
          (failure) => emit(
                CountryError(
                  message: failure.mapFailureToMessage,
                ),
              ),
          (countryStat) => emit(CountryLoaded(
              countryStat: countryStat, countryList: countryList))),
    );
  }

  Future<void> _onGetCountry(
    GetCountryStatEvent event,
    Emitter<CountryState> emit,
  ) async {
    emit(CountryLoading());
    final failureOrCountryList = await getCountryList(NoParams());
    final failureOrCountryStat = await getCountryStat(Params(slug: event.slug));
    _eitherLoadedAfterGetCountryOrErrorState(
        failureOrCountryStat, failureOrCountryList, emit);
  }
}
