import 'package:flutter/material.dart';
import 'HomePage.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  // ignore: non_constant_identifier_names
  var select_index = 0;

  List children = [
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          //to be filled be future_resv and history
        ),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
              child: InkWell(
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xff62e3e3),
                  ),
                  child: Icon(Icons.filter_list, color: Colors.black),
                ),
                splashColor: Color(0xff62e3e3),
                onTap: (){
                  Scaffold.of(context).openDrawer();
                },//to a settings page
              ),
            ),
            title: Center(child: Text('HOME', style: TextStyle(fontFamily: 'Gotu', color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold))),
            backgroundColor: Colors.black,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xff62e3e3),
                    ),
                    child: Icon(Icons.more_vert, color: Colors.black,),
                  ),
                  splashColor: Color(0xff62e3e3),
                  onTap: (){
                  },//to a settings page
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          backgroundColor: Color(0xff000000),
          selectedItemColor: Color(0xff62e3e3),
          unselectedItemColor: Color(0xffffffff),
          currentIndex: select_index,
          onTap: (currIndex) {
            setState(() {
            select_index = currIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              title: Text("Explore"),
              icon: Icon(Icons.explore, size: 30.0),
            ),
            BottomNavigationBarItem(
              title: Text("Serch"),
              icon: Icon(Icons.search, size: 30.0),
            ),
            BottomNavigationBarItem(
              title: Text("Profile"),
              icon: Icon(Icons.person, size: 30.0),
            ),
          ],
        ),
        backgroundColor: Color(0xff000000),
        body: children[select_index],
    );
  }
}