import 'package:cloud_firestore/cloud_firestore.dart';

class ScanObject {
  String title;
  String textAsString;
  DateTime date;

  ScanObject({
    this.title,
    this.date,
    this.textAsString,
  });

  factory ScanObject.fromJson(Map<String, dynamic> json) {
    return ScanObject(
      title: json["title"],
      textAsString: json["textAsString"],
      date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
    );
  }

  factory ScanObject.fromJsonCloud(Map<String, dynamic> json) {
    Timestamp myTimestamp = json["date"];
    return ScanObject(
      title: json["title"],
      textAsString: json["textAsString"],
      date: DateTime.fromMillisecondsSinceEpoch(myTimestamp.millisecondsSinceEpoch),
    );
  }

  Map<String, dynamic> toMapForLocalDb() {
    Map<String, dynamic> map = {
      "title": title,
      "textAsString": textAsString,
      "date": date.millisecondsSinceEpoch,
    };
    return map;
  }

  Map<String, dynamic> toMapForCloudDb() {
    Map<String, dynamic> map = {
      "title": title,
      "textAsString": textAsString,
      "date": date.millisecondsSinceEpoch,
    };
    return map;
  }
}
