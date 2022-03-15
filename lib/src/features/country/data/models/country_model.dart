import 'package:covid_tracker/src/features/country/domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required String country,
    required String slug,
    required String iso2,
  }) : super(
          country: country,
          slug: slug,
          iso2: iso2,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      country: json["Country"],
      slug: json["Slug"],
      iso2: json["ISO2"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Country': country,
      'Slug': slug,
      'ISO2': iso2,
    };
  }
}
