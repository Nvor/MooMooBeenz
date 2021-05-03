import 'package:MooMooBeenz_App/screens/home.dart';
import 'package:MooMooBeenz_App/screens/password-reset.dart';
import 'package:MooMooBeenz_App/screens/register.dart';
import 'package:MooMooBeenz_App/services/auth.dart';
import 'package:MooMooBeenz_App/widgets/drawer.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = new AuthService();
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

                    if (form.validate()) {
                      try {
                        form.save();
                        var user = authService.loginUser(_email, _password);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage())
                        );
                      } on Exception catch (error) {
                        throw new Exception("Error trying to login");
                      }
                    }
                  }),
              SizedBox(height: 10.0),
              OutlinedButton(
                child: Text("Forgot Password?"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordResetPage())
                  );
                }
              ),
              SizedBox(height: 5.0),
              OutlinedButton(
                child: Text('Don\'t have an account? Sign up.'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage())
                  );
                },
              )
            ],
          ),
        )
      ),
      drawer: CustomDrawer()
    );
  }
}