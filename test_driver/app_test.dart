// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//flutter drive --target=test_driver/app.dart
void main() {
  group('Scanner App', () {
    final emailTextfield = find.byValueKey('Email');
    final passwordTextfield = find.byValueKey('Password');
    final loginButton = find.byValueKey('Login');
    final settingsButton = find.byValueKey('SettingsButton');
    final logoutButton = find.byValueKey('LogoutButton');
    final scannerButton = find.byValueKey('ScannerButton');
    final cloudSaveButtton = find.byValueKey('CloudButton');
    final localSaveButton = find.byValueKey('LocalButton');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("login page test", () async {
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
      driver.tap(scannerButton);
      sleep(Duration(seconds:5));
    });
  });
}
