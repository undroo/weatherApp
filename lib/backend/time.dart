String showDate(DateTime now) {
  String date;
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  date = now.day.toString() + " " + months[now.month - 1];
  return date;
}

String showTime(DateTime now) {
  String time;
  String hour = now.hour.toString();
  String minute = now.minute.toString();
  String end = "am";
  if (now.hour > 12) {
    hour = (now.hour - 12).toString();
    end = "pm";
  }
  if (now.minute < 10) {
    minute = "0" + minute;
  }
  time = hour + ":" + minute + end;
  return time;
}

String fullTime(DateTime now) {
  String full;
  full = showDate(now) + ", " + showTime(now);
  return full;
}
