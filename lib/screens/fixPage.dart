import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:env_app/screens/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FixPage extends StatefulWidget {
  FixPage({Key key, this.uid}) : super(key: key);
  String uid;

  @override
  _FixPageState createState() => _FixPageState();
}

class _FixPageState extends State<FixPage> {
  List<DocumentSnapshot> list;

  void initState() {
    super.initState();
    getEntryList();
  }

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return CircularProgressIndicator();
    }
    if (list.length == 0) {
      return Scaffold(
        body: Center(
          child: Text('Nothing to update'),
        ),
      );
    }
    else {
      return Scaffold(
          body: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                return FlatButton(
                  color: Colors.transparent,
                  child: Image(
                    image: Image.network(list[i].data["initial"]).image,
                    height: 250,
                  ),
                  onPressed: () {
                    getImageFromCamera(i);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                );
              }));
    }
  }

  getEntryList() async {
    QuerySnapshot snap =
        await Firestore.instance.collection("entries").getDocuments();
    List<DocumentSnapshot> hold = snap.documents;
    print(hold.length);
    for (int i = 0; i < hold.length; i++) {
      print(hold[i].documentID);
      if (hold[i].data.containsKey("fixed") || hold[i].data.containsKey("stop")) {
        print('remove');
        hold.removeAt(i);
        i--;
      }
    }
    print(hold.length);
    setState(() {
      list = hold;
    });
  }

  Future getImageFromCamera(int index) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await uploadFile(image, index);
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('photos/${basename(image.path)}');
      var url = await storageReference.getDownloadURL();
      Firestore.instance
          .collection('entries')
          .document(list[index].documentID)
          .updateData({'fixed': url, 'fixUid': widget.uid});
    }
  }

  Future uploadFile(File image, int index) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('photos/${basename(image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
  }
}
