import 'package:env_app/screens/camera.dart';
import 'package:env_app/screens/community.dart';
import 'package:flutter/material.dart';
import 'package:env_app/widgets/home_drawer.dart';
import 'package:env_app/screens/login.dart';
import 'package:env_app/widgets/map_widget.dart';
import 'package:env_app/screens/community.dart';
import 'package:env_app/screens/profile.dart';
import 'package:env_app/screens/leaderboard.dart';

import 'login.dart';

class Home extends StatefulWidget{

  Home({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedTab = 0;
   var _pageOptions = [
    Map(),
    Community(),
    //PhotoPage(),
    Leaderboard(),
    //Voting(),
    Profile(),
  ];

   /*
  void initState() {
    super.initState();
    _pageOptions = [
      PhotoPage(uid: widget.uid,),
      Community(uid: widget.uid,),
      Leaderboard(),
      Profile(),
    ];
  }
*/


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            leading: IconButton(icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.person_outline, color: Colors.black),
                onPressed: () {},),
            ],
          ),

        body: _pageOptions[_selectedTab],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map'),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Community'),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              title: Text('Leaderboard'),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],

        ),





      ),
    );
  }
}