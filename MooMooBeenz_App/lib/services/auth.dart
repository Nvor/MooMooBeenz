import 'package:MooMooBeenz_App/models/user.dart';
import 'package:MooMooBeenz_App/services/secure-storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'api.dart';

class AuthService with ChangeNotifier {
  ApiService api = new ApiService();
  SecureStorageService secureStorage = new SecureStorageService();
  var currentUser;

  AuthService() {
    print("AuthService Initialized");
  }

  Future<User> getUser() {
    return Future.value(currentUser);
  }

  Future<User> createUser(String email, String password, String firstName, String lastName) async {
    var createUserResult = await api.post("registration", body: {
      "username": email,
      "password": password,
      "firstname": firstName,
      "lastname": lastName
    });

    User user = User.fromJson(createUserResult);
    if (user.id > 0) {
      storeIdentity(createUserResult);
      currentUser = user;
    } else {
      currentUser = null;
    }

    return user;
  }

  Future<User> loginUser(String email, String password) async {
    var loginResult = await api.post("login", body: {
      "username": email,
      "password": password
    });

    User user = User.fromJson(loginResult);
    if (user.id > 0) {
      storeIdentity(loginResult);
      currentUser = user;
      return currentUser;
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

  Future<void> storeIdentity(dynamic authResult) async {
    await secureStorage.set("access_token", authResult['access_token']);
    await secureStorage.set("refresh_token", authResult['refresh_token']);
  }
}