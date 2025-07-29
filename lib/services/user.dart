import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fltuter_b16/models/user.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }

  ///Get User By ID
  Future<UserModel> getUserByID(String userID) async {
    return await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(userID)
        .get()
        .then((user) => UserModel.fromJson(user.data()!));
  }
}
