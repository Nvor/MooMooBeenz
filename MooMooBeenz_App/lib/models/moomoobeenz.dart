import 'package:flutter/cupertino.dart';

class MooMooBeenz {
  int id;
  int userId;
  int raterId;
  int mooMooBeenz;

  MooMooBeenz({@required this.id, @required this.userId, @required this.raterId, @required this.mooMooBeenz});

  factory MooMooBeenz.fromJson(Map<String, dynamic> json) {
    return MooMooBeenz(
      id: json['id'],
      userId: json['userId'],
      raterId: json['raterId'],
      mooMooBeenz: json['mooMooBeenz']
    );
  }
}