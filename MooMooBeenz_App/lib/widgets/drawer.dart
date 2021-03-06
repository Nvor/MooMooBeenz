import 'package:MooMooBeenz_App/screens/login.dart';
import 'package:MooMooBeenz_App/screens/password-reset.dart';
import 'package:MooMooBeenz_App/screens/register.dart';
import 'package:MooMooBeenz_App/screens/settings.dart';
import 'package:MooMooBeenz_App/services/auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  AuthService authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove any padding from the ListView
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("MooMooBeenz"),
            decoration: BoxDecoration(
              color: Colors.purple
            ),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () {
              Navigator.pop(context);
            }
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              this.logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage())
              );
            }
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Register'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage())
              );
            }
          ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text('Forgot Password'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PasswordResetPage())
              );
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              Navigator.pop(context);
            }
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage())
              );
            }
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Close'),
            onTap: () {
              Navigator.pop(context);
            }
          )
        ]
      )
    );
  }

  void logout() async {
    await authService.logoutUser();
  }
}