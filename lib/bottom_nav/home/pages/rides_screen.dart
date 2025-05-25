import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:sharide/widgets/confirm_order_page.dart';
import 'package:sharide/widgets/rides_list_tile.dart';

import '../../../models/rides_model.dart';
import '../../../repository/rides_repository.dart';

class RidesScreen extends StatefulWidget {
  final RidesModel? ridesModel;
  
  const RidesScreen({
    super.key,
    this.ridesModel,
  });

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
                        .where(Filter.or(
                            Filter("polypoints",
                                arrayContains: widget.ridesModel!.points
                                    .map((e) => LatLngExtension.toJson(e))
                                    .toList()
                                    .first),
                            Filter("polypoints",
                                arrayContainsAny: widget.ridesModel!.points
                                    .map((e) => LatLngExtension.toJson(e))
                                    .toList()
                                    .sublist(0, 20))))
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => Gap(10),
                            itemBuilder: (context, index) {
                              RidesModel data =
                                  snapshot.data!.docs[index].data();
                              if (data.points.contains(
                                      widget.ridesModel?.points.last) ||
                                  data.points.contains(widget
                                          .ridesModel?.points[
                                      widget.ridesModel!.points.length - 10])) {
                                return RidesListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ConfirmOrderPage(
                                          ridesModel: data,
                                        ),
                                      ),
                                    );
                                  },
                                  title: "${data.transportType}",
                                  seats: data.seat,
                                  description: data.description,
                                  price: data.price.toString(),
                                  time: data.date,
                                );
                              } else {
                                return Gap(0);
                              }
                            },
                            itemCount: snapshot.data!.docs.length,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.error}"),
                          );
                        } else {
                          return SizedBox();
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )
            ],
          );
        }),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
      // floatingActionButton: ElevatedButton(
      //   onPressed: () {

      //   },
      //   child: Text(
      //     "Choose",
      //     style: TextStyle(fontSize: 23),
      //   ),
      // ),
    );
  }
}
