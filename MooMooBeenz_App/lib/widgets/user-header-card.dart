import 'package:MooMooBeenz_App/services/user-service.dart';
import 'package:flutter/material.dart';

class UserHeaderCard extends StatelessWidget {
  UserService userService = new UserService();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text('UserImg')
            ),
            Expanded(
              flex: 8,
              child: Text(getUserFullName())
            )
          ]
        )
      )
    );
  }

  String getUserFullName() {
    return userService.getFullName();
  }
}