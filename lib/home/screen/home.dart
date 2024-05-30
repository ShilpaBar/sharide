import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sharide/book_ride_screen.dart';
import 'package:sharide/home/profile_management_screens/ride_history_screen.dart';
import 'package:sharide/set_location_screen.dart';
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
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.person),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text(
                    "Select a ride",
                    style: TextStyle(fontSize: 27),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      splashColor: Colors.grey,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetLocationScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Color(0xFFD9D9D9),
                        child: Image.asset(
                          "assets/images/Car.png",
                          scale: 3.6,
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookRideScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Color(0xFFD9D9D9),
                        child: Image.asset(
                          "assets/images/Car.png",
                          scale: 3.6,
                        ),
                      ),
                    ),
                    Text(
                      "Book a ride",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Rides history",
                    style: TextStyle(fontSize: 27),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 105),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RideHistoryScreens(),
                          ),
                        );
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF009963),
                        ),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 250,
              width: 350,
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFB4D5B9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1 May, 2023",
                          style: TextStyle(
                              color: Color(0xFF009963),
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            "Rs. 123",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 6,
                          color: Color(0xFF009963),
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.grey,
                              offset: Offset(0, 3))
                        ],
                      ),
                    ),
                    title: Text(
                      "Pickup location",
                      style: TextStyle(
                          color: Color(0xFF6F6C6C),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Rarina Market",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 6,
                          color: Color(0xFF009963),
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.grey,
                              offset: Offset(0, 3))
                        ],
                      ),
                    ),
                    title: Text(
                      "Dropoff location",
                      style: TextStyle(
                          color: Color(0xFF6F6C6C),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Dgobpu Market",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
