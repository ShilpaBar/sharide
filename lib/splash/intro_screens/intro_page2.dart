import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          "assets/lotties/2.json",
          height: 300,
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          "Confirm Your Driver",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Huge drivers network helps you find comfortable, safe and cheap",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
