import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:sharide/authentication/authentication.dart';
import 'package:sharide/bnb/bottom_nav_screen.dart';
import 'package:sharide/models/user_model.dart';
import 'package:sharide/otp_screen.dart';
import 'package:sharide/repository/user_repository.dart';

import 'widgets/custom_textfeild.dart';

class SignUpPage extends StatefulWidget {
  final String phoneNo;
  const SignUpPage({super.key, required this.phoneNo});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  String? imagePath;
  String? imageUrl;
  Reference referenceRoot =
      FirebaseStorage.instance.ref().child("profile_images");
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserRepository>(builder: (userRepository) {
      return GetBuilder<AuthenticationContoller>(builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Sharide"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 40),
                ),
                Gap(30),
                Text(
                  "Please register your account to sign in",
                  style: TextStyle(fontSize: 16, color: Color(0xFF999999)),
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!))
                          : AssetImage(
                              "assets/images/man.png",
                            ) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          PLog.green("selected Image--${file?.path}");
                          if (file != null) {
                            imagePath = file.path;
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFF009963),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextfeild(
                  prefixIcon: Icons.person,
                  labelText: "Full name",
                  textEditingController: fullNameTextController,
                ),
                CustomTextfeild(
                    prefixIcon: Icons.email,
                    labelText: "Email address",
                    textEditingController: emailTextController),

                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (imagePath != null) {
                      try {
                        Reference ref = referenceRoot
                            .child(DateTime.now().toIso8601String());
                        await ref.putFile(File(imagePath!));

                        imageUrl = await ref.getDownloadURL();
                        PLog.yellow(imageUrl ?? "faild");
                        if (imageUrl != null) {
                          imagePath = null;
                        }
                        setState(() {});
                      } catch (error) {}
                    }
                    await userRepository.createUser(
                      UserModel(
                        fullName: fullNameTextController.text,
                        phoneNo: widget.phoneNo,
                        email: emailTextController.text,
                        profilePic: imageUrl,
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigationScreen(),
                        ),
                        (route) => false);
                    PLog.yellow(userRepository.userModel!.toString());
                  },
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                Divider(
                  color: Color(0xFF999999),
                  height: 70,
                  indent: 20,
                  endIndent: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Already have an account? ",
                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //     ),
                //     TextButton(
                //         onPressed: () {
                //           Navigator.pop(context);
                //         },
                //         child: Text(
                //           "Sign In",
                //           style:
                //               TextStyle(fontSize: 17, color: Color(0xFF009963)),
                //         ))
                //   ],
                // )
              ],
            ),
          ),
        );
      });
    });
  }
}
