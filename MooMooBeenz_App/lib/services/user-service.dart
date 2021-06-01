import 'dart:convert';
import 'package:MooMooBeenz_App/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class UserService with ChangeNotifier {
  ApiService api = new ApiService();
  SharedPreferences sharedPrefs;
  User currentUser;
  UserService() {
    initUser();
  }

  Future<User> initUser() async {
    sharedPrefs = await SharedPreferences.getInstance();
    this.currentUser = User.fromJson(jsonDecode(sharedPrefs.getString('user')));
    return currentUser;
  }

  Future<User> getUser() async {
    return currentUser;
  }

  Future<User> getUserById() async {
    var getResult = await api.get("user", {
      "id": currentUser.id.toString()
    });

    User user = User.fromJson(getResult["user"]);
    if (user.id > 0) {
      currentUser = user;
      sharedPrefs.setString('user', jsonEncode(currentUser));
    }

    return currentUser;
  }

  Future<User> saveUserData(User user) async {
    var saveResult = await api.post("user", {
      "id": user.id.toString(),
      "firstname": user.firstname,
      "lastname": user.lastname,
      "summary": user.summary,
      "picture": user.picture
    });

    User updatedUser = User.fromJson(saveResult);
    if (updatedUser != null) {
      currentUser = updatedUser;
      sharedPrefs.setString('user', jsonEncode(currentUser));
    }

    return currentUser;
  }

  String getUsername() {
    return currentUser.username ?? "";
  }

  String getFirstName() {
    return currentUser.firstname ?? "";
  }

  String getLastName() {
    return currentUser.lastname ?? "";
  }

  String getFullName() {
    return "${currentUser.firstname} ${currentUser.lastname}";
  }

  String getPicture() {
    return currentUser.picture ?? "";
  }
}