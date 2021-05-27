// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//flutter drive --target=test_driver/app.dart
void main() {
  group('Counter App', () {
    final emailTextfield = find.byValueKey('Email');
    final passwordTextfield = find.byValueKey('Password');
    final loginButton = find.byValueKey('Login');
    final settingsButton = find.byValueKey('SettingsButton');
    final logoutButton = find.byValueKey('LogoutButton');

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

    test("test textfield", () async {
      driver.tap(emailTextfield);
      driver.enterText("ali@hrw.de");
      //sleep(Duration(seconds: 1));
      driver.tap(passwordTextfield);
      driver.enterText("qwert123");
      //sleep(Duration(seconds: 1));
      driver.tap(loginButton);
      expect(await driver.getText(emailTextfield), "ali@hrw.de");
      expect(await driver.getText(passwordTextfield), "qwert123");
      driver.tap(loginButton);
      sleep(Duration(seconds: 5));
      driver.tap(settingsButton);
      sleep(Duration(seconds: 2));
      driver.tap(logoutButton);
      sleep(Duration(seconds: 5));
      //expect(await driver.getText(loginButton), "ali@hrw.de");
    });

    // test('starts at 0', () async {
    //   // Use the `driver.getText` method to verify the counter starts at 0.
    //   expect(await driver.getText(counterTextFinder), "0");
    // });

    // test('increments the counter', () async {
    //   // First, tap the button.
    //   await driver.tap(buttonFinder);
    //
    //   // Then, verify the counter text is incremented by 1.
    //   expect(await driver.getText(counterTextFinder), "1");
    // });
  });
}
