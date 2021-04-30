import 'package:MooMooBeenz_App/widgets/labeled-switch.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  bool notifications = false;
  bool rememberLogin = false;
  bool hideProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings')
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            LabeledSwitch(
                label: 'Notifications on/off',
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                value: notifications,
                onChanged: (bool newValue) {
                  setState(() {
                    notifications = newValue;
                  });
                }
            ),
            LabeledSwitch(
                label: 'Remember login',
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                value: rememberLogin,
                onChanged: (bool newValue) {
                  setState(() {
                    rememberLogin = newValue;
                  });
                }
            ),
            LabeledSwitch(
                label: 'Hide my profile',
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                value: hideProfile,
                onChanged: (bool newValue) {
                  setState(() {
                    hideProfile = newValue;
                  });
                }
            )
          ],
        )
      )
      /*body: Container(
        child: Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
          activeTrackColor: Colors.grey,
          activeColor: Colors.purple
        )
      )*/
    );
  }
}