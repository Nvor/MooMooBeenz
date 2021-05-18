import 'package:flutter/cupertino.dart';

class User {
  int id;
  String username;
  String firstname;
  String lastname;
  String picture;

  User({@required this.id, @required this.username, @required this.firstname, @required this.lastname, @required this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      picture: json['picture']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'firstname': firstname,
    'lastname': lastname,
    'picture': picture
  };
}