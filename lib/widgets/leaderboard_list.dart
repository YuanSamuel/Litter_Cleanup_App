import 'package:env_app/models/person.dart';
import 'package:flutter/material.dart';
import 'package:env_app/widgets/leaderboard_tile.dart';

class LeaderboardList extends StatefulWidget{


  @override
  _LeaderboardList createState() => _LeaderboardList();
}

class _LeaderboardList extends State<LeaderboardList>{
  List<person> people = [
    person (1,  'Vincent',  'profile.jpg', 100),
    person (2,  'Lucas',  'profile1.jpg', 90),
    person (3,  'Samuel',  'profile2.jpg', 80),
    person (4,  'Prasan',  'profile3.jpg', 70),
    person (5,  'Aditya',  'profile4.jpg', 60),
    person (6,  'Ian',  'profile5.jpg', 50),
    person (7,  'Abdur',  'profile6.jpg', 40),
    person (8,  'Connor',  'profile7.jpg', 30),
    person (9,  'Will',  'profile8.jpg', 20),
    person (10,  'Taemin',  'profile9.jpg', 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height- 260,
      child:
      Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: people.length,
          itemBuilder: (_, index) {
            return LeaderboardTile(
              rank: people[index].rank,
              name: people[index].name,
              picture: people[index].picture,
              points: people[index].points,
            );
          },
        ),
      )
    );
  }
}
