// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//flutter drive --target=test_driver/app.dart
void main() {
  group('Scanner App', () {
    final settingsButton = find.byValueKey('SettingsButton');
    final logoutButton = find.byValueKey('LogoutButton');
    final scannerButton = find.byValueKey('ScannerButton');
    final cloudSaveButtton = find.byValueKey('CloudButton');
    final localSaveButton = find.byValueKey('LocalButton');

    FlutterDriver driver;

    setUpAll(() async {
      final String adbPath = 'C:/Users/aliko/AppData/Local/Android/Sdk/platform-tools/adb.exe';
      await Process.run(adbPath, ['shell', 'pm', 'grant', 'alikortak.hrw_textscanner', 'android.permission.READ_EXTERNAL_STORAGE']);
      await Process.run(adbPath, ['shell', 'pm', 'grant', 'alikortak.hrw_textscanner', 'android.permission.WRITE_EXTERNAL_STORAGE']);
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
      final emailTextfield = find.byValueKey('Email');
      final passwordTextfield = find.byValueKey('Password');
      final loginButton = find.byValueKey('Login');

      driver.tap(emailTextfield);
      sleep(Duration(seconds: 2));
      driver.enterText("ali@hrw.de");
      sleep(Duration(seconds: 2));
      driver.tap(passwordTextfield);
      sleep(Duration(seconds: 2));
      driver.enterText("qwert123");
      sleep(Duration(seconds: 2));
      driver.tap(loginButton);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("Check if saved data exists", () async {
      sleep(Duration(seconds: 2));
      final cloudButton = find.byValueKey('CloudButton');
      driver.tap(cloudButton);
      sleep(Duration(seconds: 4));
      final cloudData = find.byValueKey('Cloud Data: 2');
      driver.getText(cloudData).then((value) => expect(
          value,
          'Prewview: Text Message\n'
          'Today 15:46Its Emma. I tried to call you but\n'
          'signal bad. I been taken to\n'
          'hospital after having a fall this\n'
          'morning. If possible can you do\n'
          'me a quick favour and text me x'));
      sleep(Duration(seconds: 4));
    });

    test("Scan image", () async {
      print("waited 2 Secunds");
      sleep(Duration(seconds: 2));
      final homeButton = find.byValueKey("Scanner");
      driver.tap(homeButton);
      sleep(Duration(seconds: 2));
      final scannerButton = find.byValueKey("ScannerButton");
      driver.tap(scannerButton);
      sleep(Duration(seconds: 5));
      final image = find.byValueKey("BackButton");
      driver.tap(image);
      sleep(Duration(seconds: 4));
    });

    test("test Premission", () async {
      final emailTextfield = find.byValueKey('Email');
      final passwordTextfield = find.byValueKey('Password');
      final loginButton = find.byValueKey('Login');
      driver.tap(emailTextfield);
      driver.enterText("ali@hrw.de");
      driver.tap(passwordTextfield);
      driver.enterText("qwert123");
      driver.tap(loginButton);
      expect(await driver.getText(emailTextfield), "ali@hrw.de");
      expect(await driver.getText(passwordTextfield), "qwert123");
      driver.tap(loginButton);
      sleep(Duration(seconds: 5));

      driver.tap(scannerButton);
      sleep(Duration(seconds: 2));
    });

    test("login page test", () async {
      final emailTextfield = find.byValueKey('Email');
      final passwordTextfield = find.byValueKey('Password');
      final loginButton = find.byValueKey('Login');
      driver.tap(emailTextfield);
      driver.enterText("ali@hrw.de");
      driver.tap(passwordTextfield);
      driver.enterText("qwert123");
      driver.tap(loginButton);
      expect(await driver.getText(emailTextfield), "ali@hrw.de");
      expect(await driver.getText(passwordTextfield), "qwert123");
      driver.tap(loginButton);
      sleep(Duration(seconds: 5));
      driver.tap(cloudSaveButtton);
      sleep(Duration(seconds: 5));
      driver.tap(localSaveButton);
      sleep(Duration(seconds: 5));
      driver.tap(settingsButton);
      sleep(Duration(seconds: 2));
      driver.tap(logoutButton);
      sleep(Duration(seconds: 5));
    });

    test('Photo recognitation', () async {
      final emailTextfield = find.byValueKey('Email');
      final passwordTextfield = find.byValueKey('Password');
      final loginButton = find.byValueKey('Login');
      driver.tap(emailTextfield);
      driver.enterText("ali@hrw.de");
      driver.tap(passwordTextfield);
      driver.enterText("qwert123");
      driver.tap(loginButton);
      expect(await driver.getText(emailTextfield), "ali@hrw.de");
      expect(await driver.getText(passwordTextfield), "qwert123");
      driver.tap(loginButton);
      sleep(Duration(seconds: 2));
      driver.tap(scannerButton);
      sleep(Duration(seconds: 2));
    });
  });
}
