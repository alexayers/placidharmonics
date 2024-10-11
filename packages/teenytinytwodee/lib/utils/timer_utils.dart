class TimerUtil {
  int _startTime = 0;
  int waitTime = 0;

  int get startTime => _startTime;

  void start() {
    _startTime = DateTime.now().millisecondsSinceEpoch;
  }

  void reset() {
    _startTime = DateTime.now().millisecondsSinceEpoch;
  }

  bool hasTimePassed() {
    return _startTime + waitTime < DateTime.now().millisecondsSinceEpoch;
  }

  double getPercentRemaing() {
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    final int timePassed = currentTime - _startTime;
    final int timeRemaining = waitTime - timePassed;

    return timeRemaining / waitTime;
  }
}
