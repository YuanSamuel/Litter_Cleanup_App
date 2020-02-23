import 'package:env_app/models/friend.dart';
import 'package:flutter/material.dart';
import 'package:env_app/widgets/leaderboard_tile.dart';

class FriendsList extends StatefulWidget{


  @override
  _FriendsList createState() => _FriendsList();
}

class _FriendsList extends State<FriendsList>{
  List<friend> friends = [
    friend ('Vincent',  'profile.jpg', 100),
    friend ('Lucas',  'profile1.jpg', 90),
    friend ('Samuel',  'profile2.jpg', 80),
    friend ('Prasan',  'profile3.jpg', 70),
    friend ('Aditya',  'profile4.jpg', 60),
    friend ('Ian',  'profile5.jpg', 50),
    friend ('Abdur',  'profile6.jpg', 40),
    friend ('Connor',  'profile7.jpg', 30),
    friend ('Will',  'profile8.jpg', 20),
    friend ('Taemin',  'profile9.jpg', 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height- 260,
        child:
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: friends.length,
          itemBuilder: (_, index) {
            return LeaderboardTile(
              name: friends[index].name,
              picture: friends[index].picture,
              points: friends[index].points,
            );
          },
        )
    );
  }
}
