import 'package:MooMooBeenz_App/screens/home.dart';
import 'package:MooMooBeenz_App/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  AuthService authService = new AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _firstname;
  String _lastname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register")
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Register',
                style: TextStyle(fontSize: 20)
              ),
              SizedBox(height: 20.0),
              TextFormField(
                onSaved: (value) => _email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                onSaved: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              ),
              TextFormField(
                onSaved: (value) => _firstname = value,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                onSaved: (value) => _lastname = value,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Last Name"),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("REGISTER"),
                onPressed: () {
                  final form = _formKey.currentState;

                  if (form.validate()) {
                    try {
                      form.save();
                      var user = authService.createUser(_email, _password, _firstname, _lastname);
                      if (user == null) {
                        throw new Exception("Error creating new user");
                      } else {
                        //on successful registration, login and navigate home
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage())
                        );
                      }
                    } on Exception catch (error) {
                      //registration error to UI
                    }
                  }
                }
              )
            ]
          )
        )
      )
    );
  }
}