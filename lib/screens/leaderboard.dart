import 'package:flutter/material.dart';
import 'camera.dart' as camera;
class Leaderboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    camera.PhotoPage p = new camera.PhotoPage();
    p.createState().getImageFromCamera()
    return Scaffold(
      body: Text(
          'Leaderboard'
      ),
    );
  }
}

