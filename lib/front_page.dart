import 'package:flutter/material.dart';
import 'package:sharide/intro_screens/intro_page1.dart';
import 'package:sharide/intro_screens/intro_page2.dart';
import 'package:sharide/intro_screens/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.70),
            child: SmoothPageIndicator(controller: _controller, count: 3),
          ),
        ],
      ),
    );
  }
}
