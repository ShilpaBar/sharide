import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sharide/widgets/confirm_order_page.dart';
import 'package:sharide/widgets/rides_list_tile.dart';

import 'models/rides_model.dart';
import 'repository/rides_repository.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
        child: GetBuilder<RidesRepository>(builder: (ridesRepo) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose a ride",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<RidesModel>>(
                    stream: ridesRepo.ridesDb
                        .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => Gap(10),
                            itemBuilder: (context, index) {
                              RidesModel data =
                                  snapshot.data!.docs[index].data();

                              return RidesListTile(
                                title: "${data.transportType}",
                                seats: data.seat,
                                description: data.description,
                                price: data.price.toString(),
                                time: data.date,
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.hasError.toString()}"),
                          );
                        } else {
                          return SizedBox();
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      // return ListView.separated(
                      //   itemCount: 15,
                      //   separatorBuilder: (context, index) => SizedBox(
                      //     height: 7,
                      //   ),
                      //   itemBuilder: (context, index) => RidesListTile(
                      //     image: "assets/images/Auto.png",
                      //     title: "Car Go",
                      //     seats: 4,
                      //     description: "Affordable, compact rides",
                      //     price: "120.34",
                      //   ),
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      // );
                    }),
              )
            ],
          );
        }),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmOrderPage(),
            ),
          );
        },
        child: Text(
          "Choose",
          style: TextStyle(fontSize: 23),
        ),
      ),
    );
  }
}
