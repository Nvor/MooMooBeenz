import 'dart:convert';
import 'package:MooMooBeenz_App/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService with ChangeNotifier {
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