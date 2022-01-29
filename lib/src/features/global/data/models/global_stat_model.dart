import 'package:covid_tracker/src/features/global/domain/entities/global_stat.dart';

class GlobalStatModel extends GlobalStat {
  const GlobalStatModel({
    required int newConfirmed,
    required int totalConfirmed,
    required int newDeaths,
    required int totalDeaths,
    required int newRecovered,
    required int totalRecovered,
    required DateTime date,
  }) : super(
          newConfirmed: newConfirmed,
          totalConfirmed: totalConfirmed,
          newDeaths: newDeaths,
          totalDeaths: totalDeaths,
          newRecovered: newRecovered,
          totalRecovered: totalRecovered,
          date: date,
        );

  factory GlobalStatModel.fromJson(Map<String, dynamic> json) {
    return GlobalStatModel(
      newConfirmed: json["Global"]["NewConfirmed"],
      totalConfirmed: json["Global"]["TotalConfirmed"],
      newDeaths: json["Global"]["NewDeaths"],
      totalDeaths: json["Global"]["TotalDeaths"],
      newRecovered: json["Global"]["NewRecovered"],
      totalRecovered: json["Global"]["TotalRecovered"],
      date: DateTime.parse(json["Date"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newConfirmed': newConfirmed,
      'totalConfirmed': totalConfirmed,
      'newDeaths': newDeaths,
      'totalDeaths': totalDeaths,
      'newRecovered': newRecovered,
      'totalRecovered': totalRecovered,
      'date': date.toIso8601String(),
    };
  }
}
