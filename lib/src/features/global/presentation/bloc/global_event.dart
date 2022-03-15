part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();
}

class GetGlobalStatEvent extends GlobalEvent {
  @override
  List<Object?> get props => [];
}
