import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrw_textscanner/objects/ScanObject.dart';
import 'package:hrw_textscanner/sqflite/Database.dart';

class CloudDbScreen extends StatefulWidget {
  @override
  _CloudDbScreenState createState() => _CloudDbScreenState();
}

class _CloudDbScreenState extends State<CloudDbScreen> {
  List<ScanObject> scanObjectList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Cloud Database",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection("ScanObject").get(),
          builder: (context, snapshot) {
            scanObjectList = [];
            if (snapshot.hasError) {
              return Text(snapshot.connectionState.toString());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              snapshot.data.docs.forEach((element) {
                print(element.data());
                scanObjectList.add(ScanObject.fromJsonCloud(element.data()));
              });
              return ListView.builder(
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
              );
            }
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}

/*
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
 */
