import 'package:flutter/material.dart';

class Voting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
           RichText(
            text: TextSpan(children: [
              TextSpan(text: 'Before, ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
            ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
          ),

          SizedBox(
            height: 400,
            width: 400,
            child: Image(image: AssetImage('assets/messy1.JPG')),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: 'After, ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
            ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
          ),
          SizedBox(
            height: 400,
            width: 400,
            child: Image(image: AssetImage('assets/clean1.JPG')),
          ),

        ],
      )
    );
  }
}

