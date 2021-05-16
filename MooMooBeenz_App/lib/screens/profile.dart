import 'package:MooMooBeenz_App/widgets/moomoobeenz-card.dart';
import 'package:MooMooBeenz_App/widgets/user-header-card.dart';
import 'package:MooMooBeenz_App/widgets/user-summary-card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile")
      ),
      body: Container(
        child: ListView(
          children: <Widget> [
            UserHeaderCard(),
            MooMooBeenzCard(),
            UserSummaryCard()
          ]
        )
      )
    );
  }
}