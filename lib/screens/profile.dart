import 'package:flutter/material.dart';

class Profile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
            Text(
              'Vincent Do',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Avid Conservationalist',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.orange.shade700,
              ),
            ),
            Container(color: Colors.white,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add_a_photo,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Photos Taken: 23',
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                  Icons.add_location,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 10.0,
                ),
                  Text(
                  'Challenges Accepted: 15',
                  style: TextStyle(
                    color: Colors.orange.shade900,
                    fontSize: 20.0,
              ),
            ),
          ],
        ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Average Rating: 4.8',
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}

