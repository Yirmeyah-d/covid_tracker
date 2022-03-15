import 'package:equatable/equatable.dart';

class TimeSeriesCases extends Equatable {
  final DateTime time;
  final int cases;

  const TimeSeriesCases({
    required this.time,
    required this.cases,
  });

  @override
  List<Object> get props => [time, cases];
}
