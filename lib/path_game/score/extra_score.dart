import 'dart:async';

const maxSeconds = 100;

class ExtraScore {
  int extraScore = 100;
  int secondsLeft = maxSeconds;
  late ExtraScoreCallback onExtraScoreChanged;
  late SecondsCallback onSecondsChanged;
  bool stopped = false;

  void setListeners(
      {required ExtraScoreCallback extraScoreCallback,
      required SecondsCallback secondsCallback}) {
    onExtraScoreChanged = extraScoreCallback;
    onSecondsChanged = secondsCallback;
  }

  start() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsLeft -= 1;
      if (secondsLeft == 0 || stopped) {
        timer.cancel();
        return;
      }
      onSecondsChanged(secondsLeft);
      if (secondsLeft % 10 == 0) {
        extraScore -= 10;
        onExtraScoreChanged(extraScore);
      }
    });
  }

  void stop() {
    stopped = true;
  }
}

typedef ExtraScoreCallback = void Function(int extraScore);
typedef SecondsCallback = void Function(int seconds);