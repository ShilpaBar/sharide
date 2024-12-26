import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sharide/bottom_nav/activity/ride_history_screen.dart';
import 'home/home.dart';
import 'profile/profile.dart';

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
      body: [
        Home(
          onProfileTap: () {
            setState(() {
              currentIndex = 2;
            });
          },
        ),
        RideHistoryScreens(),
        Profile()
      ].elementAt(currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF009963),
        buttonBackgroundColor: Color(0xFF009963),
        backgroundColor: Colors.black26,
        animationCurve: Curves.easeInOut,
        height: 55,
        index: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: [
          Icon(
            Icons.home,
            size: 35,
          ),
          Icon(
            Icons.bookmark_outlined,
            size: 35,
          ),
          Icon(
            Icons.person,
            size: 35,
          )
        ],
      ),
    );
  }
}
