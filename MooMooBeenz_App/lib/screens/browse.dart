import 'package:MooMooBeenz_App/screens/view.dart';
import 'package:flutter/material.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key key}) : super(key: key);

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  List userCards = new List.generate(20, (i) => UserCard()).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Browse")
      ),
      body: Container(
        child: ListView(
          children: [
            UserCard(),
            UserCard(),
            UserCard()
          ]
        )
      )
    );
  }
}

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(30.0),
            child: Row(
                children: <Widget>[
                  Icon(Icons.face),
                  Text("Test Name")
                ]
          )
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewPage())
        );
      }
    );
  }
}