import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoteScreen extends StatefulWidget {
  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  DocumentSnapshot entry;
  double vote = 5.0;

  void initState() {
    super.initState();
    getEntry();
  }

  @override
  Widget build(BuildContext context) {
    if (entry == null) {
      return CircularProgressIndicator();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Vote!"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: Image.network(entry.data["imageLink"]).image,
              ),
            ),
            Text(vote.round().toString()),
            Slider(
              value: vote,
              min: 0,
              max: 10,
              label: "hi",
              onChanged: (value) {
                setState(() {
                  vote = value;
                });
              },
            ),
            RaisedButton(
              child: Text("Submit"),
              onPressed: () {
                submitVote();
              }
            )
          ],
        ));
  }

  getEntry() async {
    print('hi');
    QuerySnapshot value =
        await Firestore.instance.collection("entries").getDocuments();
    List<DocumentSnapshot> docs = value.documents;
    for (DocumentSnapshot eachEntry in docs) {
      if (eachEntry.data["votes"].length < 3) {
        print(eachEntry.data.toString());
        setState(() {
          entry = eachEntry;
        });
        break;
      }
    }
  }

  submitVote() async {
    DocumentReference value = await Firestore.instance.collection("entries").document(entry.documentID);
    DocumentSnapshot snap = await value.get();
    List newVotes = snap.data['votes'];
    newVotes.add(vote.round());
    value.setData({
      "votes": newVotes
    });
  }
}
