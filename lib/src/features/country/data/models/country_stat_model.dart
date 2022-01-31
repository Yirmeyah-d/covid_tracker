import 'package:covid_tracker/src/features/country/domain/entities/country_stat.dart';

class CountryStatModel extends CountryStat {
  const CountryStatModel({
    required String country,
    required int confirmed,
    required int death,
    required int recovered,
    required int active,
    required DateTime date,
  }) : super(
          country: country,
          confirmed: confirmed,
          death: death,
          recovered: recovered,
          active: active,
          date: date,
        );

  factory CountryStatModel.fromJson(Map<String, dynamic> json) {
    return CountryStatModel(
      country: json["Country"],
      confirmed: json["Confirmed"],
      death: json["Deaths"],
      recovered: json["Recovered"],
      active: json["Active"],
      date: DateTime.parse(json["Date"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Country': country,
      'Confirmed': confirmed,
      'Deaths': death,
      'Recovered': recovered,
      'Active': active,
      'Date': date.toIso8601String(),
    };
  }
}
