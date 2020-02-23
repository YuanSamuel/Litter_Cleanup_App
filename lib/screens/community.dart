import 'package:flutter/material.dart';
import 'package:env_app/widgets/friends_categories.dart';

class Community extends StatefulWidget{
  @override
  _Community createState() => _Community();
}

class _Community extends State<Community>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FriendsCategories(),
        ],

      ),
    );
  }
}