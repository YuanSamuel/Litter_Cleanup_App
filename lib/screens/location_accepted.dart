import 'package:env_app/models/pin_data.dart';
import 'package:env_app/utilities/constants.dart';
import 'package:env_app/utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:env_app/utilities/theme.dart';
import 'package:env_app/screens/camera.dart';

class LocationAccepted extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 400,
                    width: (MediaQuery.of(context).size.width / 2) * 0.8,
                    child: Image(image: AssetImage('assets/messy1.JPG'),),
                  ),
                ),
                /*
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 400,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image(image: AssetImage('assets/messy1.JPG'),),
                  ),
                ),*/
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 300,
                      width: (MediaQuery.of(context).size.width / 2) * 0.8,
                      child: Image(image: AssetImage('assets/clean1.JPG'),),
                    ),
                    PhotoPage(),

                  ],
                )

              ],
            ),
              Container(
              alignment: Alignment.centerLeft,
              //decoration: kBoxDecorationStyle,
              height: 200.0,
              child: TextField(
              obscureText: false,
              style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              hintText: 'Comments',
              hintStyle: kHintTextStyleBlack,
              ),
            )
            ),
            RaisedButton(
              child: Text('Submit'),
            )
          ],
        )
      ),
    );
  }
}

