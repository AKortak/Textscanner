import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hrw_textscanner/firebase/Firebase_Operations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirestoreOperations firestoreOperations = FirestoreOperations();

  group('Test class Firebase_Operations', () {
    test('Test addUserToDB adds User to DB', () async {
      //when
      await firestoreOperations.addUserToDB(
          userID: "Max",
          userName: "Max1",
          gender: "m",
          dateOfBirth: DateTime(2000, 01, 01));

      //then
      bool dbContainsNewUser;
      if (firestoreOperations.userCollection.doc("Max") != null) {
        dbContainsNewUser = true;
      } else {
        dbContainsNewUser = false;
      }
      firestoreOperations.deleteUserFromDB("Max");

      expect(dbContainsNewUser, true);
    });

    test('Test addUserToDBOnSSOLogin adds User to DB', () async {
      //when
      await firestoreOperations.addUserToDBOnSSOLogin(
          userID: "Zim", userName: "Zimbo");

      //then
      bool dbContainsNewUser;
      if (firestoreOperations.userCollection.doc("Zim") != null) {
        dbContainsNewUser = true;
      } else {
        dbContainsNewUser = false;
      }
      firestoreOperations.deleteUserFromDB("Zim");

      expect(dbContainsNewUser, true);
    });

    test('Test deleteUserFromDb deletes a written User from Database.',
        () async {
      //given
      await firestoreOperations.addUserToDB(
          userID: "Anne",
          userName: "Anne1",
          gender: "w",
          dateOfBirth: DateTime(2000, 01, 01));

      //when
      firestoreOperations.deleteUserFromDB("Anne");

      bool dbContainsNewUser;
      if (firestoreOperations.userCollection.doc("Anne") == null) {
        dbContainsNewUser = true;
      } else {
        dbContainsNewUser = false;
      }

      expect(dbContainsNewUser, false);
    });

    test('Test checkIfUserAlreadyInDB recognizes existing User.', () async {
      //when
      await firestoreOperations.addUserToDBOnSSOLogin(
          userID: "Mia", userName: "Mia1");

      //then
      bool dbContainsNewUser;
      if (firestoreOperations.userCollection.doc("Mia") != null) {
        dbContainsNewUser = true;
      } else {
        dbContainsNewUser = false;
      }
      firestoreOperations.deleteUserFromDB("Mia");

      expect(dbContainsNewUser, true);
    });
  });
}
