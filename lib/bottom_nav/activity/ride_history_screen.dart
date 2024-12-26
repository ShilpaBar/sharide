import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:sharide/models/rides_model.dart';
import 'package:sharide/repository/rides_repository.dart';
import 'package:sharide/repository/user_repository.dart';
import 'package:sharide/widgets/history_list_tile.dart';

class RideHistoryScreens extends StatefulWidget {
  const RideHistoryScreens({super.key});

  @override
  State<RideHistoryScreens> createState() => _RideHistoryScreensState();
}

UserRepository userRepo = Get.find<UserRepository>();

class _RideHistoryScreensState extends State<RideHistoryScreens> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RidesRepository>(builder: (rideRepo) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Rides History"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot<RidesModel>>(
          stream: rideRepo.ridesDb
              .where("id", isEqualTo: userRepo.userModel!.phoneNo)
              .orderBy("date", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              PLog.green("${snapshot.error}");
              return Center(
                child: Text("Something Went Wrong ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("No History Found"),
                );
              } else {
                return ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      RidesModel data = snapshot.data!.docs[index].data();

                      return HistoryListTile(
                        pickUpLocation: data.location ?? "N/A",
                        dropLocation: data.destination ?? "N/A",
                        charge: data.price,
                        dateTime: data.date,
                      );
                    });
              }
            } else {
              return Center(
                child: Text("Something Went Wrong"),
              );
            }
          },
        ),
      );
    });
  }
}
