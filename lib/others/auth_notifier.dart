import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_Entity.dart';

class AuthNotifier with ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  UserModel? _userDetails;
  UserModel? get userDetails => _userDetails;
  void setUserDetails(UserModel userModel) {
    _userDetails = userModel;
    notifyListeners();
  }
}
