import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_quiz_app/core/utils/ticker.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/timer_bloc/timer_event.dart';
import 'package:flutter_bloc_quiz_app/screens/quiz_details_screen/bloc/timer_bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc(this.ticker) : super(const TimerInitial()) {
    on<TimerStart>((event, emit) {
      _tickerSub?.cancel();
      _tickerSub = ticker.tick().listen((duration) => add(TimerTick(duration)));
    });

    on<TimerTick>((event, emit) {
      emit(TimerRunning(event.duration));
    });

    add(const TimerStart());
  }

  final Ticker ticker;
  StreamSubscription<int>? _tickerSub;

  @override
  Future<void> close() {
    _tickerSub?.cancel();
    return super.close();
  }
}
