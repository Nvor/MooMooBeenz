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

  void initUser() async {
    sharedPrefs = await SharedPreferences.getInstance();
    this.currentUser = jsonDecode(sharedPrefs.getString('user'));
  }

  String getUsername() {
    return currentUser.username ?? "";
  }

  String getFirstName() {
    return currentUser.firstName ?? "";
  }

  String getLastName() {
    return currentUser.lastName ?? "";
  }

  String getFullName() {
    return "${currentUser.firstName} ${currentUser.lastName}";
  }

  String getPicture() {
    return currentUser.picture ?? "";
  }
}