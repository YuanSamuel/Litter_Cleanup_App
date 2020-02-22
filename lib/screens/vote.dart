import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoteScreen extends StatefulWidget {
  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  DocumentSnapshot entry;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: FutureBuilder<void>(
          future: getEntry(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            }
            else {
              return Column(
                children: <Widget>[
              Image(
              image: Image.network(src),
            ),
                ],
              );
            }
      }),
    );
  }

  Future<DocumentSnapshot> getEntry() async {
    Firestore.instance
        .collection("entries")
        .getDocuments()
        .then((QuerySnapshot value) {
      List<DocumentSnapshot> docs = value.documents;
      for (DocumentSnapshot eachEntry in docs) {
        if (eachEntry.data["votes"].length < 3) {
          setState(() {
            return eachEntry;
          });
        }
      }
    });
  }
}
