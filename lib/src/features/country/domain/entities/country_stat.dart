import 'package:equatable/equatable.dart';

class CountryStat extends Equatable {
  final String country;
  final int confirmed;
  final int death;
  final int recovered;
  final int active;
  final DateTime date;

  const CountryStat({
    required this.country,
    required this.confirmed,
    required this.death,
    required this.recovered,
    required this.active,
    required this.date,
  });

  @override
  List<Object> get props => [
        country,
        confirmed,
        death,
        recovered,
        active,
        date,
      ];
}
