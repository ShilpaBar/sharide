import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sharide/bnb/bottom_nav_screen.dart';
import 'package:sharide/repository/user_repository.dart';

import 'authentication/authentication.dart';
import 'models/user_model.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationContoller>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E2E2E),
                  ),
                  child: Text(
                    "Resend",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (true) {
                      final x = controller.user!.uid;
                      User user = controller.user!;
                      await Get.find<UserRepository>().createUser(UserModel(
                          fullName: user.displayName ?? "",
                          phoneNo: user.phoneNumber ?? "",
                          email: user.email ?? "",
                          profilePic: user.photoURL ?? ""));

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavigationScreen(),
                          ),
                          (r) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF009963),
                  ),
                  child: Text(
                    "Confirm",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
