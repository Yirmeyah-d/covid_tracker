import 'package:covid_tracker/src/core/error/failures.dart';
import 'package:covid_tracker/src/core/use_case/use_case.dart';
import 'package:covid_tracker/src/core/utils/failure_api.dart';
import 'package:covid_tracker/src/features/global/domain/entities/global_stat.dart';
import 'package:covid_tracker/src/features/global/domain/use_cases/get_global_stat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final GetGlobalStat getGlobalStat;

  GlobalBloc({
    required this.getGlobalStat,
  }) : super(GlobalInitial()) {
    on<GetGlobalStatEvent>(_onGetGlobalStat);
  }

  void _eitherLoadedOrErrorState(
    Either<Failure, GlobalStat> failureOrGlobalStat,
    Emitter<GlobalState> emit,
  ) {
    failureOrGlobalStat.fold(
      (failure) => emit(
        GlobalError(
          message: failure.mapFailureToMessage,
        ),
      ),
      (globalStat) => emit(GlobalLoaded(globalStat: globalStat)),
    );
  }

  Future<void> _onGetGlobalStat(
    GetGlobalStatEvent event,
    Emitter<GlobalState> emit,
  ) async {
    emit(GlobalLoading());
    final failureOrGlobalStat = await getGlobalStat(NoParams());
    _eitherLoadedOrErrorState(failureOrGlobalStat, emit);
  }
}
