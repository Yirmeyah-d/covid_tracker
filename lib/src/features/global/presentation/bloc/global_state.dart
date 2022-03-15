part of 'global_bloc.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();
}

class GlobalInitial extends GlobalState {
  @override
  List<Object> get props => [];
}

class GlobalLoading extends GlobalState {
  @override
  List<Object> get props => [];
}

class GlobalLoaded extends GlobalState {
  final GlobalStat globalStat;
  const GlobalLoaded({required this.globalStat});

  @override
  List<Object> get props => [globalStat];
}

class GlobalError extends GlobalState {
  final String message;
  const GlobalError({required this.message});

  @override
  List<Object> get props => [message];
}
