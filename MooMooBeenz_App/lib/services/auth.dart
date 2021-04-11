import 'package:flutter/material.dart';
import 'dart:async';

class AuthService with ChangeNotifier {
  var currentUser;

  AuthService() {
    print("AuthService Initialized");
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  Future createUser(
    { String email,
      String password,
      String firstName,
      String lastName
    }) async {}

  Future loginUser({String email, String password}) {
    if (password == "placeholderTrue") {
      this.currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }

  Future logoutUser() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }
}