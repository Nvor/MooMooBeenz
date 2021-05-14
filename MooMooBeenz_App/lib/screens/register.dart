import 'package:MooMooBeenz_App/screens/home.dart';
import 'package:MooMooBeenz_App/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  AuthService authService = new AuthService();
  bool isLoading = false;
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
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              Center(
                child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20)
                )
              ),
              SizedBox(height: 20.0),
              TextFormField(
                onSaved: (value) => _email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => (value == null || value.isEmpty) ? "Email is required" : null,
              ),
              TextFormField(
                onSaved: (value) => _password = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) => (value == null || value.isEmpty) ? "Password is required" : null,
              ),
              TextFormField(
                onSaved: (value) => _firstname = value,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "First Name"),
                validator: (value) => (value == null || value.isEmpty) ? "First name is required" : null,
              ),
              TextFormField(
                onSaved: (value) => _lastname = value,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "Last Name"),
                validator: (value) => (value == null || value.isEmpty) ? "Last name is required" : null,
              ),
              SizedBox(height: 20.0),
              !isLoading ? ElevatedButton(
                child: Text("REGISTER"),
                onPressed: () {
                  this.register();
                })
              : Center(
                child: CircularProgressIndicator()
              )
            ]
          )
        )
      )
    );
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });
    final form = _formKey.currentState;

    if (form.validate()) {
      try {
        form.save();
        var user = await authService.createUser(_email, _password, _firstname, _lastname);
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage())
          );
        }
      } on Exception catch (error) {
        throw new Exception("Error creating new user");
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}