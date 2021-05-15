import 'package:MooMooBeenz_App/screens/profile.dart';
import 'package:MooMooBeenz_App/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'activity.dart';
import 'browse.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> pages = [
    ProfilePage(
      key: PageStorageKey('ProfilePage')
    ),
    BrowsePage(
      key: PageStorageKey('BrowsePage')
    ),
    ActivityPage(
      key: PageStorageKey('ActivityPage')
    )
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).home),
        //actions: <Widget>[LogoutButton()],
      ),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket
      ),
      bottomNavigationBar: bottomNavigationBar(_selectedIndex),
      //body: Center(
      //  child: Text('Home Page Content'),
      //),
      drawer: CustomDrawer(),
    );
  }

  Widget bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
    onTap: (int index) => setState(() => _selectedIndex = index),
    currentIndex: selectedIndex,
    items: const <BottomNavigationBarItem> [
      BottomNavigationBarItem(
        icon: Icon(Icons.face_retouching_natural),
        label: "Profile"
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.saved_search),
        label: "Browse"
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.local_activity),
        label: "Activity"
      )
    ]
  );
}