import 'package:flutter/material.dart';
import 'package:env_app/models/person.dart';

class LeaderboardTile extends StatelessWidget {
  final int rank;
  final String name;
  final String picture;
  final int points;

  LeaderboardTile(
      {@required this.rank, @required this.name, @required this.picture, @required this.points});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container (
            child: CircleAvatar(
              radius: 35.0,
              backgroundImage: AssetImage("assets/$picture"),
            ),
            padding: EdgeInsets.all(2.0),
          ),
          Column(
            children: <Widget>[

              Text(name.toString(),
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),
              ),
              Text('Rank '+rank.toString(),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87

                ),
              ),
            ],
          ),
          Container (
            child: Text(points.toString()+' points',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87
              ),
            ),
          )
        ],
      ),
    );
  }
}
