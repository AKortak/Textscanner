// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:hrw_textscanner/objects/ScanObject.dart';
import 'package:hrw_textscanner/sqflite/Database.dart';
import 'package:image_picker/image_picker.dart';

class PictureScanner extends StatefulWidget {
  const PictureScanner({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PictureScannerState();
}

class _PictureScannerState extends State<PictureScanner> {
  File _imageFile;
  Size _imageSize;
  VisionText visionText;
  String textAsString = "";
  String title;
  TextEditingController titleController;
  TextEditingController scannedTextController;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("ScanObject");
  bool _validate = false;

  @override
  void initState() {
    titleController = TextEditingController();

    super.initState();
  }

  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();

  Future<void> _getAndScanImage() async {
    setState(() {
      _imageFile = null;
      _imageSize = null;
    });
    final PickedFile pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    final File imageFile = File(pickedImage.path);
    setState(() {
      _imageFile = imageFile;
    });

    if (imageFile != null) {
      await Future.wait([
        _getImageSize(imageFile),
        _scanImage(imageFile),
      ]);
    }
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();
    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  Future<void> _scanImage(File imageFile) async {
    textAsString = "";
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    dynamic results;
    results = await _recognizer.processImage(visionImage);
    //print(results);
    for (final TextBlock block in results.blocks) {
      textAsString = textAsString + block.text;
    }
    setState(() {});
    //print(textAsString);
  }

  Widget showText() {
    return Text(textAsString);
  }

  validationSuccessfulLokal() {
    DB.insert(
      DB.scanHistory,
      ScanObject(title: titleController.text, date: DateTime.now(), textAsString: scannedTextController.text).toMapForLocalDb(),
    );
    _validate = false;
  }

  validationSuccessfulCloud() {
    collectionReference.add(
      ScanObject(title: titleController.text, date: DateTime.now(), textAsString: scannedTextController.text).toMapForCloudDb(),
    );
    _validate = false;
  }

  Widget _buildContainerAfterImageScanned() {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 180,
                  width: 180,
                  child: InteractiveViewer(
                      panEnabled: false, // Set it to false
                      boundaryMargin: EdgeInsets.all(100),
                      minScale: 0.5,
                      maxScale: 2,
                      child: Image.file(_imageFile)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Titel: ",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                child: Center(
                  child: TextField(
                    onChanged: (val) {
                      title = val;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    ),
                    maxLines: 1,
                    controller: titleController,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Scann-Ergebnis: ",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
                  ),
                  maxLines: 30,
                  controller: scannedTextController = TextEditingController(text: textAsString),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    child: Text(
                      "Speichern lokal",
                      textAlign: TextAlign.start,
                    ),
                    onPressed: () {
                      setState(() {
                        titleController.text.isEmpty ? _validate = true : validationSuccessfulLokal();
                      });
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Speichern auf Cloud",
                      textAlign: TextAlign.start,
                    ),
                    onPressed: () {
                      setState(() {
                        titleController.text.isEmpty ? _validate = true : validationSuccessfulCloud();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'HRW-Textscanner',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _imageFile == null ? Container(color: Colors.white, child: Center(child: Text('No image selected.'))) : _buildContainerAfterImageScanned(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: _getAndScanImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  void dispose() {
    _recognizer.close();
    super.dispose();
  }
}
