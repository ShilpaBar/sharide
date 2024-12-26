import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:sharide/bottom_nav/activity/ride_history_screen.dart';
import 'package:sharide/bottom_nav/profile/views/edit_profile.dart';
import 'package:sharide/models/rides_model.dart';
import 'package:sharide/repository/rides_repository.dart';
import 'package:sharide/repository/user_repository.dart';
import 'package:sharide/bottom_nav/home/pages/share_ride_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  final Function()? onProfileTap;
  const Home({super.key, this.onProfileTap});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  RidesModel lastRide = RidesModel();
  PageController pageController = PageController();
  List<String> imageList = [
    "assets/images/banner.jpg",
    "assets/images/Banner2.jpg",
    "assets/images/Banner3.jpg",
  ];
  // RidesModel? lastRide;
  RidesRepository ridesRepo = Get.find<RidesRepository>();
  UserRepository userRepository = Get.find<UserRepository>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userRepo.setPaymentMethodRef(userRepository.userModel!.phoneNo);

      await ridesRepo.ridesDb
          .where("id", isEqualTo: userRepo.userModel!.phoneNo)
          .get()
          .then(
            (value) => setState(() {
              if (value.docs.isNotEmpty) {
                lastRide = value.docs.last.data();
              } else {
                lastRide = RidesModel();
              }
            }),
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserRepository>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Welcome ${userRepository.userModel!.fullName ?? ""}"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
            ),
          ],
          leadingWidth: 50,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "${userRepository.userModel!.profilePic ?? "https://cdn-icons-png.flaticon.com/128/4140/4140048.png"}"),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
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
              Row(
                children: [
                  Text(
                    "Select a ride",
                    style: TextStyle(fontSize: 27),
                  ),
                ],
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
                              builder: (context) => ShareRideScreen(),
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
                              builder: (context) => ShareRideScreen(
                                isBooking: true,
                              ),
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
              if (lastRide.id != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rides history",
                      style: TextStyle(fontSize: 27),
                    ),
                    TextButton(
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
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  // height: 250,
                  width: 365,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFB4D5B9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " ${DateFormat('EEEE, MMM d').format(lastRide.date)}",
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
                                "${lastRide.price}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
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
                          "${lastRide.location}",
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
                          "${lastRide.destination}",
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
            ],
          ),
        ),
      );
    });
  }
}
