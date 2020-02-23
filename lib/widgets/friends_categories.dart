import 'package:flutter/material.dart';

class FriendsCategories extends StatefulWidget{
  @override
  _FriendsCategories createState() => _FriendsCategories();
}

class _FriendsCategories extends State<FriendsCategories>{

  int selectedIndex = 0;
  final List<String> categories = ['Friends', 'Nearby', 'Favorites'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Theme.of(context).primaryColor,
      //build the list view for messages, online, etc
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
              ),
              child: Text(categories[index],
                style: TextStyle(
                  //if index is selected index, make it white, but if it's not make it the lighter shade
                  color: index == selectedIndex ? Colors.white : Colors.white60,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}