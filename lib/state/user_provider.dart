import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _userLoggedIn = true;

  void setUserAuth(bool authState) {
    _userLoggedIn = authState;
    notifyListeners();
  }

  bool get userState => _userLoggedIn;
}