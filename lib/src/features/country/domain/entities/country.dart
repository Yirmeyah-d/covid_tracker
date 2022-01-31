import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String country;
  final String slug;
  final String iso2;

  const Country({
    required this.country,
    required this.slug,
    required this.iso2,
  });

  @override
  List<Object> get props => [country, slug, iso2];
}
