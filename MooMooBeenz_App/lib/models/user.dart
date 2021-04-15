import 'package:flutter/cupertino.dart';

class User {
  int id;
  String username;
  String firstName;
  String lastName;
  String picture;

  User({@required this.id, @required this.username, @required this.firstName, @required this.lastName, @required this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      picture: json['picture']
    );
  }
}