import 'dart:convert';
import 'dart:io';
import 'package:MooMooBeenz_App/models/user.dart';
import 'package:MooMooBeenz_App/services/secure-storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'api.dart';

class AuthService with ChangeNotifier {
  ApiService api = new ApiService();
  SecureStorageService secureStorage = new SecureStorageService();
  User currentUser;

  AuthService() {
    print("AuthService Initialized");
  }

  Future<User> getUser() {
    return Future.value(currentUser);
  }

  Future<User> createUser(String email, String password, String firstName, String lastName) async {
    var createUserResult = await api.post("registration", {
      "username": email,
      "password": password,
      "firstname": firstName,
      "lastname": lastName
    });

    User user = User.fromJson(createUserResult["user"]);
    if (user.id > 0) {
      storeIdentity(createUserResult);
      currentUser = user;
      return currentUser;
    } else {
      currentUser = null;
    }

    return user;
  }

  Future<User> loginUser(String email, String password) async {
    var loginResult = await api.post("login", {
      "username": email,
      "password": password
    });

    User user = User.fromJson(loginResult["user"]);
    if (user.id > 0) {
      storeIdentity(loginResult);
      currentUser = user;
      return currentUser;
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }

  Future logoutUser() async {
    await deleteIdentity();
    await api.post("logout/access", {}, headers: await getAuthorizationHeaders());
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  Future<Map<String, String>> getAuthorizationHeaders() async {
    return {
      HttpHeaders.authorizationHeader: "Bearer ${await secureStorage.get("access_token")}"
    };
  }

  Future<void> storeIdentity(dynamic authResult) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(currentUser));

    await secureStorage.set("access_token", authResult['access_token']);
    await secureStorage.set("refresh_token", authResult['refresh_token']);
  }

  Future<void> deleteIdentity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');

    await secureStorage.delete("access_token");
    await secureStorage.delete("refresh_token");
  }
}