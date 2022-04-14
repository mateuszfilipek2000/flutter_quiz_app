abstract class TimerEvent {
  const TimerEvent();
}

class TimerStart extends TimerEvent {
  const TimerStart();
}

class TimerTick extends TimerEvent {
  const TimerTick(this.duration);

  final int duration;
}

class TimerStop extends TimerEvent {
  const TimerStop();
}
