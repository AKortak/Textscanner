// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PictureScanner extends StatefulWidget {
  const PictureScanner({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PictureScannerState();
}

class _PictureScannerState extends State<PictureScanner> {
  File _imageFile;
  Size _imageSize;
  dynamic _scanResults;
  VisionText visionText;
  String textAsString = "";

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
    print(results);
    for (final TextBlock block in results.blocks) {
      textAsString = textAsString + block.text;
    }
    print(textAsString);
  }

  CustomPaint _buildResults(Size imageSize, dynamic results) {
    CustomPainter painter;

    return CustomPaint(
      painter: painter,
    );
  }

  Widget showText() {
    return Text(textAsString);
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),

      // image: DecorationImage(image: Image.file(_imageFile).image),

      child: Column(
        children: [
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(image: Image.file(_imageFile).image),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Text(
                    textAsString,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HRW-Textscanner'),
      ),
      body: _imageFile == null ? const Center(child: Text('No image selected.')) : _buildImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAndScanImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  @override
  void dispose() {
    _recognizer.close();

    super.dispose();
  }
}
