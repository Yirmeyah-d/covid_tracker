part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();
}

class CountryInitial extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoading extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoaded extends CountryState {
  final List<CountryStat> countryStat;
  final List<Country> countryList;

  const CountryLoaded({required this.countryStat, required this.countryList});

  @override
  List<Object> get props => [countryStat, countryList];
}

class CountryError extends CountryState {
  final String message;
  const CountryError({required this.message});

  @override
  List<Object> get props => [message];
}
