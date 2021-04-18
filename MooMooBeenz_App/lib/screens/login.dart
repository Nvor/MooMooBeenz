import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  onSaved: (value) => _email = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) => (value == null || value.isEmpty) ? "Username is required" : null,
              ),
              TextFormField(
                  onSaved: (value) => _password = value,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) => (value == null || value.isEmpty) ? "Password is required" : null,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  child: Text("SIGN IN"),
                  onPressed: () {
                    final form = _formKey.currentState;
                    form.save();

                    if (form.validate()) {
                      try {
                        //call auth api here

                      } on Exception catch (error) {
                        //auth error to UI
                      }
                    }
                  }),
              SizedBox(height: 20.0),
              Text('Forgot Password?'),
              SizedBox(height: 10.0),
              Text('Don\'t have an account? Sign up.')
            ],
          ),
        )
      ),
    );
  }
}