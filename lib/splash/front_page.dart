import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharide/authentication/authentication.dart';
import 'package:sharide/splash/intro_screens/intro_page1.dart';
import 'package:sharide/splash/intro_screens/intro_page2.dart';
import 'package:sharide/splash/intro_screens/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../bottom_nav/bottom_nav_screen.dart';
import '../onboarding/signin_page.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  AuthenticationContoller googleSignInContoller =
      Get.find<AuthenticationContoller>();
  PageController _controller = PageController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (googleSignInContoller.user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigationScreen(),
            ),
            (r) => false);
      }
    });
    super.initState();
  }

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ),
                (r) => false,
              );
            },
            child: Text(
              "Get Started",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) => setState(() {
              page = value;
            }),
            controller: _controller,
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 100),
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            child: SmoothPageIndicator(controller: _controller, count: 3),
          ),
        ],
      ),
    );
  }
}
