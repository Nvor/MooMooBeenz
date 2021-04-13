import 'package:flutter/cupertino.dart';

class UserMooMooBeenz {
  int id;
  int userId;
  int raterId;
  int mooMooBeenz;

  UserMooMooBeenz({@required this.id, @required this.userId, @required this.raterId, @required this.mooMooBeenz});

  factory UserMooMooBeenz.fromJson(Map<String, dynamic> json) {
    return UserMooMooBeenz(
      id: json['id'],
      userId: json['userId'],
      raterId: json['raterId'],
      mooMooBeenz: json['mooMooBeenz']
    );
  }
}