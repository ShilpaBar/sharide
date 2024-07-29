import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sharide/onboarding/signin_page.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lotties/3.json",
            height: 300,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Choose your way of \ntraveling",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Please login to back your Ride or share a Ride",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
