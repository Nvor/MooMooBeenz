import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email")),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 20.0),
            RaisedButton(child: Text("SIGN IN"), onPressed: () {})
          ],
        ),
      ),
    );
  }
}