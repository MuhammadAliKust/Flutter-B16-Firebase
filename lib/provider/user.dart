import 'package:firebase_auth/firebase_auth.dart';
import 'package:fltuter_b16/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel();

  void setUser(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  UserModel getUser() => _userModel;
}
