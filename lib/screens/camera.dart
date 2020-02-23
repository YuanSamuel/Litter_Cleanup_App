import 'dart:async';
import 'dart:io';

import 'package:env_app/screens/fixPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhotoPage extends StatefulWidget {

  PhotoPage({Key key, this.uid}) : super(key: key);

  String uid;

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 20,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera),
              //onPressed: getImageFromCamera,
            ),
            IconButton(
              icon: Icon(Icons.photo),
            )
          ],
        )
    );
  }
}