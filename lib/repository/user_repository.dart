import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:sharide/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final CollectionReference<UserModel> _userDb =
      FirebaseFirestore.instance.collection("users").withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );

  UserModel? userModel;
  createUser(UserModel user) async {
    await _userDb.doc(user.id).get().then((doc) async {
      doc.data() == null
          ? await _userDb.doc(user.id).set(user).whenComplete(() {
              Get.snackbar("Success", "Your account has been created.",
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.all(20),
                  backgroundColor: Color(0xFF009963),
                  colorText: Colors.white);
              userModel = user;
            }).catchError((error, StackTrace) {
              Get.snackbar("Error", "Something went wrong. Try again",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white);
              print(error.toString());
            })
          : userModel = await _userDb
              .doc(user.id)
              .get()
              .then((snapShot) => snapShot.data()!);
    });
  }

  getUser(String id) async {
    userModel =
        await _userDb.doc(id).get().then((snapShot) => snapShot.data()!);
    update();
  }

  updateUser(UserModel user) async {
    try {
      await _userDb.doc(userModel!.id).set(user).then((x) {
        userModel = user;
        update();
      });
    } catch (e) {
      PLog.red("Update Error : $e");
    }
  }
}
