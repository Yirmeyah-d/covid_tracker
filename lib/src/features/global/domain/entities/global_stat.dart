import 'package:equatable/equatable.dart';

class GlobalStat extends Equatable {
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;
  final DateTime date;

  const GlobalStat({
    required this.newConfirmed,
    required this.totalConfirmed,
    required this.newDeaths,
    required this.totalDeaths,
    required this.newRecovered,
    required this.totalRecovered,
    required this.date,
  });

  @override
  List<Object> get props => [
        newConfirmed,
        totalConfirmed,
        newDeaths,
        totalDeaths,
        newRecovered,
        totalRecovered,
        date
      ];
}
