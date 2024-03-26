import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  List<String> imageList = [
    "assets/images/banner.jpg",
    "assets/images/Banner2.jpg",
    "assets/images/Banner3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Shilpa"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
            // color: Color.fromARGB(255, 243, 243, 31),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.person),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, realIndex) => ClipRect(
              child: Image.asset(imageList[index]),
            ),
            options: CarouselOptions(
                // aspectRatio: 1,
                // viewportFraction: 0.8,
                autoPlay: true,
                padEnds: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  pageController = PageController(initialPage: index);
                  setState(() {});
                }),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                "Select a ride",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    // splashFactory: InkSplash.splashFactory,
                    splashColor: Colors.grey,
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        "assets/images/Car.png",
                        scale: 3,
                      ),
                    ),
                  ),
                  Text(
                    "Share a ride",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    // splashFactory: InkSplash.splashFactory,
                    splashColor: Colors.grey,
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        "assets/images/Car.png",
                        scale: 3,
                      ),
                    ),
                  ),
                  Text(
                    "Share a ride",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
