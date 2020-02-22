import 'package:env_app/screens/vote.dart';
import 'package:flutter/material.dart';

class Community extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text("Vote for an image"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VoteScreen()),
              );
            },
          )
        ],
      )
    );
  }
}

