class DateTimeUtil {
  static DateTime strToDttm(String dttm) {
    // timestamp -> DateTime
    return new DateTime.fromMillisecondsSinceEpoch((int.parse(dttm) ~/ 1000));
  }

  static DateTime toStdTime(DateTime dttm) {
    // convert time to GMT + 0
    return dttm.subtract(dttm.timeZoneOffset);
  }

  static DateTime toLocalTime(DateTime dttm) {
    // convert time to Local time
    DateTime now = new DateTime.now();
    return dttm.add(now.timeZoneOffset);
  }

  static String dateSub(String timestamp) {
    DateTime now = new DateTime.now();
    DateTime dttm = strToDttm((int.parse(timestamp)).toString());
    dttm = toStdTime(dttm);
    dttm = toLocalTime(dttm);

    if (now.difference(dttm).inSeconds < 60) {
      return now.difference(dttm).inSeconds.toString() + '초 전';
    } else if (now.difference(dttm).inMinutes < 60) {
      return now.difference(dttm).inMinutes.toString() + '분 전';
    } else if (now.difference(dttm).inHours < 24) {
      return now.difference(dttm).inHours.toString() + '시간 전';
    } else if (now.difference(dttm).inDays < 31) {
      return now.difference(dttm).inDays.toString() + '일';
    } else {
      return dttm.year.toString() +
          '-' +
          dttm.month.toString() +
          '-' +
          dttm.day.toString();
    }
  }
}
