import 'package:env_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoteScreen extends StatefulWidget {
  VoteScreen({Key key, this.uid}) : super(key: key);

  String uid;
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
    } else if (entry.documentID == "stop") {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("no entries"),
              RaisedButton(
                child: Text("Return"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("Vote!"),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: Image.network(entry.data["initial"]).image,
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                    Icon(Icons.arrow_forward),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: Image.network(entry.data["fixed"]).image,
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                    )
                  ],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  })
            ],
          ));
    }
  }

  getEntry() async {
    print('hi');
    QuerySnapshot value =
        await Firestore.instance.collection("entries").getDocuments();
    List<DocumentSnapshot> docs = value.documents;
    DocumentSnapshot hold = null;
    for (DocumentSnapshot eachEntry in docs) {
      if (eachEntry.documentID == "stop") {
        hold = eachEntry;
      } else if (eachEntry.data["votes"].length < 3 && eachEntry.data.containsKey("fixed")) {
        print(eachEntry.data.toString());
        setState(() {
          entry = eachEntry;
        });
        break;
      }
    }
    if (entry == null) {
      setState(() {
        entry = hold;
      });
    }
  }

  submitVote() async {
    DocumentReference value =
        Firestore.instance.collection("entries").document(entry.documentID);
    DocumentSnapshot snap = await value.get();
    List newVotes = snap.data['votes'];
    newVotes.add(vote.round());
    value.setData({
      "initial": snap.data["initial"],
      "votes": newVotes,
      "fixed": snap.data["fixed"],
      "fixUid": snap.data["fixUid"]});
    if (newVotes.length == 3) {
      int add = 0;
      for (int i = 0; i < newVotes.length; i++) {
        add += newVotes[i];
      }
      add = add ~/ 3;
      value = Firestore.instance.collection('users').document(snap.data['fixUid']);
      snap = await value.get();
      value.setData({
        "email": snap.data["email"],
        "points": snap.data["points"] + add,
        "uid": snap.data["uid"]
      });
    }
    value =
        Firestore.instance.collection("users").document(widget.uid);
    snap = await value.get();
    if (!snap.data.containsKey('points')) {
      value.setData({
        "email": snap.data["email"],
        "points": 1,
        "uid": widget.uid
      });
    }
    else {
      value.setData({
        "email": snap.data["email"],
        "points": snap.data["points"] + 1,
        "uid": widget.uid
      });
    }
  }
}
