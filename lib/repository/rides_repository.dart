import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharide/models/rides_model.dart';

class RidesRepository extends GetxController {
  static RidesRepository get instance => Get.find();

  final CollectionReference<RidesModel> ridesDb = FirebaseFirestore.instance
      .collection("rides")
      .withConverter<RidesModel>(
        fromFirestore: (snapshot, _) => RidesModel.fromMap(snapshot.data()!),
        toFirestore: (ride, _) => ride.toMap(),
      );
  // RidesModel? ridesModel;
  createRide(RidesModel ride) async {
    await ridesDb.add(ride).whenComplete(() {
      Get.snackbar("Success", "Your ride has been shared.",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20),
          backgroundColor: Color(0xFF009963),
          colorText: Colors.white);
      // ridesModel = ride;
    }).catchError((error, StackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      print(error.toString());
    });
  }
}
