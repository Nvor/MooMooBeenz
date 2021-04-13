import 'package:flutter/cupertino.dart';

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String picture;

  User({@required this.id, @required this.email, @required this.firstName, @required this.lastName, @required this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      picture: json['picture']
    );
  }
}