import 'package:flutter/material.dart';

import 'leaderboard_tile.dart';

class Leaderboard extends StatefulWidget{
  @override
}


class LeaderboardState extends State<Leaderboard> {
  List<People> people = [
    People (rank: 1, name: 'Vincent', picture: 'profile.jpg',points: 100),
    People (rank: 2, name: 'Lucas', picture: 'profile1.jpg',points: 90),
    People (rank: 3, name: 'Samuel', picture: 'profile2.jpg',points: 80),
    People (rank: 4, name: 'Prasan', picture: 'profile3.jpg',points: 70),
    People (rank: 5, name: 'Aditya', picture: 'profile4.jpg',points: 60),
    People (rank: 6, name: 'Ian', picture: 'profile5.jpg',points: 50)
    People (rank: 7, name: 'Abdur', picture: 'profile6.jpg',points: 40),
    People (rank: 8, name: 'Connor', picture: 'profile7.jpg',points: 30),
    People (rank: 9, name: 'William', picture: 'profile8.jpg',points: 20),
    People (rank: 10, name: 'Taemin', picture: 'profile9.jpg',points: 10),

  ];

  @override
  Widget build(BuildContext context)
    return Container(
      height:1000,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: people.length,
        itemBuilder: (_, index){
          return LeaderboardTile(

          )
  }
      ),
      )

}
