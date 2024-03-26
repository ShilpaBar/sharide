import 'package:curved_navigation_bar_with_label/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'screen/home.dart';
import 'screen/my_trips.dart';
import 'screen/profile.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [Home(), MyTrips(), Profile()].elementAt(currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        // showUnselectedLabels: false,
        // color: Color(0xFF009963),


        // buttonBackgroundColor:Color(0xFF009963) ,
        color:Color(0xFF009963),
        // letIndexChange: (value) => ,
        backgroundColor: Color(0xFF009963),
        buttonLabelColor: Colors.white,
        index: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: [
          CurvedNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          CurvedNavigationBarItem(
            label: "My trips",
            icon: Icon(Icons.map),
          ),
          CurvedNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
