import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Text("Take Picture"),
            onPressed: getImageFromCamera,
          )
        ],
      ),
    );
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await uploadFile(image);
    }
  }

  Future uploadFile(File image) async {
    StorageReference storageReference = FirebaseStorage.instance.ref();
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
  }
}