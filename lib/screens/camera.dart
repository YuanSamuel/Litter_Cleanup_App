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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: FlatButton(
              child: Text("Take Picture"),
              onPressed: getImageFromCamera,
            ),
          ),
          Center(
            child: FlatButton(
              child: Text("Update"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FixPage()),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await uploadFile(image);
      int points = 0;
      DocumentSnapshot snap = await Firestore.instance.collection('users').document(widget.uid).get();
      print(widget.uid);
      if (!snap.data.containsKey('points')) {
        snap.data.putIfAbsent('points', () {
          return 0;
        });
      }
      else {
        points = snap['points'];
      }
      Firestore.instance.collection('users').document(widget.uid).updateData({
        'points': points + 5
      });
    }
  }

  Future uploadFile(File image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('photos/${basename(image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    Firestore.instance.collection('entries').add({
      'initial': await storageReference.getDownloadURL(),
      'votes': []
    });
    print('set');
  }
}