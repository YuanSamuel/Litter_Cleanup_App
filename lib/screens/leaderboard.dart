import 'package:env_app/models/person.dart';
import 'package:env_app/widgets/leaderboard_categories.dart';
import 'package:env_app/widgets/leaderboard_list.dart';
import 'package:flutter/material.dart';
import 'package:env_app/widgets/leaderboard_tile.dart';
import 'package:env_app/widgets/leaderboard_categories.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}


  class _LeaderboardState extends State<Leaderboard> {


  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
          children: <Widget>[
              CategorySelector(),
              LeaderboardList(),
          ],
        )
        ,

    );
  }
}

