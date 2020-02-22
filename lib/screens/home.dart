import 'package:flutter/material.dart';
import 'package:env_app/widgets/home_drawer.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.menu, color:Colors.black), onPressed: () => _scaffoldKey.currentState.openDrawer(),),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.person_outline, color:Colors.black), onPressed: (){},),
          ],
        ),
        /*
      drawer: Drawer(
        child: Text('hello world'),
      ),*/
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                /*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),*/
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(text: 'Hello, ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                        TextSpan(text: 'what are you\nlooking for')
                      ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text('Best Experiences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    ),

                    IconButton(icon: Icon(Icons.more_horiz, color: Colors.black,), onPressed: (){},),
                  ],
                ),

                SizedBox(height: 10,),
                SizedBox(height: 25,),

//redo this to a bottom nav bar
                /*
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.home, color:Colors.black), onPressed: (){},),
                    IconButton(icon: Icon(Icons.search, color:Colors.black), onPressed: (){},),
                    IconButton(icon: Icon(Icons.favorite_border, color:Colors.black), onPressed: (){},),
                    IconButton(icon: Icon(Icons.person_outline, color:Colors.black), onPressed: (){},),
                  ],
                ),
              ),*/





              ],
            ),
          ),
        )

    );
  }