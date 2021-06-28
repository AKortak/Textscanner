import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hrw_textscanner/objects/ScanObject.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockScanObject extends Mock implements ScanObject {}

final String _testTitle = "testTitle";
final String _testText = "Dies ist ein Text fuer den Test";
final DateTime _testDateTime = DateTime.fromMillisecondsSinceEpoch(0);

void main() {
  group('Test correct Map creating in ScanObject class.', () {
    test('Test if toMapForLocalDB creates correct Map.', () {
      //given
      ScanObject scanObject = ScanObject.fromJson(getValidMap());
      Map<String, dynamic> scanObjectToMap = scanObject.toMapForLocalDb();
      Map<String, dynamic> expectedMap = getValidMap();

      //when
      bool mapsEqual = mapEquals(scanObjectToMap, expectedMap);

      //then
      expect(mapsEqual, true);
    });

    test('Test if toMapForCloudDb creates correct Map.', () {
      //given
      ScanObject scanObject = ScanObject.fromJsonCloud(getValidMap());
      Map<String, dynamic> scanObjectToMap = scanObject.toMapForCloudDb();
      Map<String, dynamic> expectedMap = getValidMap();

      //when
      bool mapsEqual = mapEquals(scanObjectToMap, expectedMap);

      //then
      expect(mapsEqual, true);
    });
  });
}

Map<String, dynamic> getValidMap() {
  Map<String, dynamic> map = {
    "title": _testTitle,
    "textAsString": _testText,
    "date": _testDateTime.millisecondsSinceEpoch
  };
  return map;
}
