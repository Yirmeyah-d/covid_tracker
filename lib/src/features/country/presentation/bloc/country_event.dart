part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class GetCountryStatEvent extends CountryEvent {
  final String slug;
  const GetCountryStatEvent(this.slug);

  @override
  List<Object> get props => [slug];
}

class GetCountryListEvent extends CountryEvent {
  @override
  List<Object?> get props => [];
}
