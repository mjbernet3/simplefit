class Formatter {
  Formatter._();

  static String secondsToTime(int totalSeconds) {
    int hours = (totalSeconds / 3600).truncate();
    int minutes = ((totalSeconds % 3600) / 60).truncate();
    int seconds = (totalSeconds % 60).truncate();

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}
