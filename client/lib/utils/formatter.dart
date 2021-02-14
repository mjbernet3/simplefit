class Formatter {
  Formatter._();

  static String secondsToHourString(int totalSeconds) {
    int hours = (totalSeconds / 3600).truncate();
    int minutes = ((totalSeconds % 3600) / 60).truncate();
    int seconds = (totalSeconds % 60).truncate();

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  static String secondsToMinuteString(int totalSeconds) {
    int minutes = (totalSeconds / 60).truncate();
    int seconds = (totalSeconds % 60).truncate();

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}
