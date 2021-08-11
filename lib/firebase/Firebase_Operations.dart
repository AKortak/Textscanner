import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreOperations {
  FirestoreOperations();
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  //Registration
  addUserToDB({
    String userID,
    String userName,
    String gender,
    DateTime dateOfBirth,
  }) async {
    Map<String, dynamic> demoData = {
      "Username": "$userName",
      "UserID": "$userID",
      "Gender": "$gender",
      "DateOfBirth": "$dateOfBirth",
    };
    // CollectionReference collectionReference =
    //     FirebaseFirestore.instance.collection('User');
    await userCollection.doc(userID).set(demoData);
    //collectionReference.add(demoData);
  }

  deleteUserFromDB(String userID) async {
    if (userID != null) {
      await userCollection.doc(userID).delete();
    }
  }

  addUserToDBOnSSOLogin({
    String userID,
    String userName,
  }) {
    Map<String, dynamic> demoData = {
      "Username": "$userName",
      "UserID": "$userID",
    };
    // CollectionReference collectionReference =
    //     FirebaseFirestore.instance.collection('User');
    userCollection.doc(userID).set(demoData);
  }

  checkIfUserAlreadyInDB(String userID) async {
    userCollection.doc(userID).get().then((value) {
      if (value.exists == false) {
        addUserToDBOnSSOLogin(userID: userID);
        print("User wurde hinzugefügt");
      } else {
        print("Nutzer existiert bereits");
      }
    });

    /*
    userCollection.where("UserID", isEqualTo: userID).get().then((value) {
      if (value.size == 0) {
        addUserToDBOnSSOLogin(userID: userID);
        print("#### Nutzer Hinzugefügt!");
      }
    });*/
  }
}
