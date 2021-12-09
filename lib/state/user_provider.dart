import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/utils/logger.dart';

class UserProvider extends ChangeNotifier {
  User? _user;


  UserProvider() {
    initUser();
  }

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      logger.d('user status - $user');
      notifyListeners();
    });
  }

  User? get user => _user;
}