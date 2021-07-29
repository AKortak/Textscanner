import 'package:hrw_textscanner/firebase/Firebase_Operations.dart';
import 'package:mockito/mockito.dart';

class MockFirestoreOperations extends Mock implements FirestoreOperations {
  Map<String, dynamic> mockedUserCollection = Map();

  @override
  addUserToDB(
      {String userID, String userName, String gender, DateTime dateOfBirth}) {
    Map<String, dynamic> newUserData = {
      "Username": "$userName",
      "UserID": "$userID",
      "Gender": "$gender",
      "DateOfBirth": "$dateOfBirth"
    };
    mockedUserCollection.addAll(newUserData);
  }

  @override
  checkIfUserAlreadyInDB(String userID) {
    if (mockedUserCollection.containsKey(userID)) {
      return true;
    }
    return false;
  }
}
