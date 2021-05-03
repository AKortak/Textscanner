import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrw_textscanner/objects/ScanObject.dart';
import 'package:hrw_textscanner/sqflite/Database.dart';

class LocalDbScreen extends StatefulWidget {
  @override
  _LocalDbScreenState createState() => _LocalDbScreenState();
}

class _LocalDbScreenState extends State<LocalDbScreen> {
  List<ScanObject> scanObjectList = [];

  dbToList() async {
    List<Map<String, dynamic>> historyList = await DB.query(DB.scanHistory);
    scanObjectList = [];
    for (int i = 0; i < historyList.length; i++) {
      setState(() {
        ScanObject scanObject = ScanObject.fromJson(historyList[i]);
        scanObjectList.add(scanObject);
      });
    }
  }

  @override
  void initState() {
    dbToList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Lokal Database",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: scanObjectList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blueGrey[100],
              child: ListTile(
                title: Text(scanObjectList[index].title),
                leading: Text(
                  "${scanObjectList[index].date.hour}:${scanObjectList[index].date.minute} Uhr\n${scanObjectList[index].date.day}.${scanObjectList[index].date.month}.${scanObjectList[index].date.year}",
                ),
                subtitle: Container(
                  height: 80,
                  child: Text(
                    "Prewview: ${scanObjectList[index].textAsString}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
