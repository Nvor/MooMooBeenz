import 'package:MooMooBeenz_App/models/user.dart';
import 'package:MooMooBeenz_App/services/user-service.dart';
import 'package:flutter/material.dart';

class UserHeaderCard extends StatelessWidget {
  UserService userService = new UserService();
  User currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: getUserData(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
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
        } else if (snapshot.hasError) {
          return Text('Error loading user data');
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }

  Future<User> getUserData() async {
    currentUser = await userService.initUser();
    return currentUser;
  }

  String getUserFullName() {
    return userService.getFullName();
  }
}