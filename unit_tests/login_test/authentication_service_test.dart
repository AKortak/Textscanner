import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hrw_textscanner/Login/authentication_service.dart';
import 'package:test/test.dart';

import '../MockFirestoreOperations.dart';

main() async {
  //setUp Framework
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final testUser = MockUser(
    isAnonymous: false,
    uid: 'bob123',
    email: 'bob@somedomain.com',
    displayName: 'Bob',
  );

  final auth = AuthenticationService(
      MockFirebaseAuth(signedIn: true, mockUser: testUser));

  //tests
  group('Test class Authentification', () {
    test('Test Method signIn() signs in. Expected: "Signed in" ', () async {
      //when
      final result =
          await auth.signIn(email: "bob@somedomain.com", password: "qwert123");
      //then
      expect(result, "Signed in");
    });
  });
}
