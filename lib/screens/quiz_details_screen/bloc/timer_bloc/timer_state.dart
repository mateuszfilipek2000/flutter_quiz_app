import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {
  const TimerInitial();
}

class TimerRunning extends TimerState {
  const TimerRunning(this.duration);

  final int duration;
  @override
  List<Object> get props => [duration];
}

class TimerFinished extends TimerState {
  const TimerFinished();
}
