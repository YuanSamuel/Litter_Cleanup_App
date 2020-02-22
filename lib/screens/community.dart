import 'package:env_app/screens/vote.dart';
import 'package:flutter/material.dart';

class Community extends StatefulWidget{

  Community({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  _CommunityState createState() => _CommunityState();
}


class _CommunityState extends State<Community>{
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
                MaterialPageRoute(builder: (context) => VoteScreen(uid: widget.uid)),
              );
            },
          )
        ],
      )
    );
  }
}

