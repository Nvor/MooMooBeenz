import 'package:MooMooBeenz_App/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'api.dart';

class AuthService with ChangeNotifier {
  ApiService api = new ApiService();
  var currentUser;

  AuthService() {
    print("AuthService Initialized");
  }

  Future<User> getUser() {
    return Future.value(currentUser);
  }

  Future<User> createUser(String email, String password, String firstName, String lastName) async {
    var user = await api.post("registration", body: {
      "username": email,
      "password": password,
      "firstname": firstName,
      "lastname": lastName
    });

    return user;
  }

  Future<User> loginUser(String email, String password) async {
    var user = await api.post("login", body: {
      "username": email,
      "password": password
    });
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