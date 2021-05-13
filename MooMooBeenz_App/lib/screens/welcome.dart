import 'package:MooMooBeenz_App/screens/register.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome")
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget> [
            SizedBox(height: 150.0),
            ElevatedButton(
              child: Text("LOGIN"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage())
                );
              }
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text("SIGN UP"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage())
                );
              }
            )
          ]
        )
      )
    );
  }
}