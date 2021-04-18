import 'package:MooMooBeenz_App/screens/login.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPage createState() => _PasswordResetPage();
}

class _PasswordResetPage extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password")
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Reset Password',
                style: TextStyle(fontSize: 20)
              ),
              SizedBox(height: 20.0),
              TextFormField(
                onSaved: (value) => _email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("SEND PASSWORD RESET"),
                onPressed: () {
                  final form = _formKey.currentState;
                  form.save();

                  if (form.validate()) {
                    try {
                      //call pw reset api

                      //return to login screen, display pw reset comm toast
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage())
                      );
                    } on Exception catch (error) {
                      //password reset error to UI
                    }
                  }
                },
              )
            ]
          )
        )
      )
    );
  }
}