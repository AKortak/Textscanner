// Imports the Flutter Driver API.
import 'dart:io';
import 'dart:math';

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
    final allowKey = find.text("text");

    final zulassenbutton = find.text("Zulassen");
    final ablehnenbutton = find.text("Ablehnen");

    final textfield = find.byValueKey("TheValueKey");

    FlutterDriver driver;

    setUpAll(() async {
      final Map<String, String> envVars = Platform.environment;
      final String adbPath = envVars['ANDROID_HOME'] + '/platform-tools/adb.exe';
      await Process.run(adbPath, ['shell', 'pm', 'grant', 'alikortak.hrw_textscanner', 'android.permission.READ_EXTERNAL_STORAGE']);
      await Process.run(adbPath, ['shell', 'pm', 'grant', 'alikortak.hrw_textscanner', 'android.permission.WRITE_EXTERNAL_STORAGE']);
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

    // test('Photo recognitation', () async {
    //   driver.tap(emailTextfield);
    //   driver.enterText("ali@hrw.de");
    //   driver.tap(passwordTextfield);
    //   driver.enterText("qwert123");
    //   driver.tap(loginButton);
    //   expect(await driver.getText(emailTextfield), "ali@hrw.de");
    //   expect(await driver.getText(passwordTextfield), "qwert123");
    //   driver.tap(loginButton);
    //   sleep(Duration(seconds: 2));
    //   driver.tap(scannerButton);
    //   sleep(Duration(seconds: 2));
    //   // driver.tap(find.text("DENY"));
    //   // sleep(Duration(seconds: 2));
    //
    //   // sleep(Duration(seconds: 5));
    //   //
    //   // expect(await driver.getText(find.text("Zulassen")), "Zulassen");
    //   //
    //   // driver.tap(ablehnenbutton);
    //   // sleep(Duration(seconds: 5));
    // });
  });
}
