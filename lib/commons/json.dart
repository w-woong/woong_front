class JsonUtils {
  static DateTime _fromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);
  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;

  static DateTime _fromJsonDt(String json) {
    return DateTime.parse(json);
  }

  static String dateTimeToJson(DateTime json) {
    String dateTimeString =
        json.toIso8601String(); // 2022-12-25T00:13:01.301720
    // var i = dateTimeString.indexOf(".");
    // if (i >= 0) {
    //   dateTimeString = dateTimeString.substring(0, i);
    // }
    var offset = json.timeZoneOffset.inMinutes;
    var h = offset ~/ 60; // or (offset/60).floor();
    var m = offset.remainder(60);
    var hh = h.abs().toString().padLeft(2, "0");
    var mm = m.abs().toString().padLeft(2, "0");

    var sign = "+";
    if (h < 0) {
      sign = "-";
    }
    var offsetString = "$sign$hh:$mm";
    return "$dateTimeString$offsetString";
    // return "2022-12-12T09:12:12+09:00";
  }

  static String stringFromJson(String? json) {
    return json ?? '';
  }

  static double doubleFromJson(double? json) {
    return json ?? 0.0;
  }

  static bool boolFromJson(bool? json) {
    return json ?? false;
  }

  static double readDouble(Map map, String key) {
    num v = map[key] as num? ?? 0.0;
    return v.toDouble();
    // var v = map[key] as double? ?? 0.0;
    // return v;
  }
}
