import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:sharide/authentication/google_signin.dart';
import 'package:sharide/models/user_model.dart';
import 'package:sharide/repository/user_repository.dart';
import 'package:sharide/widgets/custom_textfeild.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  UserRepository userRepository = Get.find<UserRepository>();
  AuthenticationContoller authController = Get.find<AuthenticationContoller>();

  String? imageUrl;
  ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    if (userRepository.userModel != null) {
      userRepository.userModel!.fullName != null
          ? nameTextController = TextEditingController(
              text: "${userRepository.userModel!.fullName}")
          : null;

      userRepository.userModel!.email != null
          ? emailTextController =
              TextEditingController(text: "${userRepository.userModel!.email}")
          : null;

      userRepository.userModel!.phoneNo != null
          ? phoneTextController = TextEditingController(
              text: "${userRepository.userModel!.phoneNo}")
          : null;
    }
    super.initState();
  }

  String? imagePath;
  Reference referenceRoot =
      FirebaseStorage.instance.ref().child("profile_images");

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserRepository>(builder: (_) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(35),
            child: Column(
              children: [
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!))
                          : NetworkImage(
                                  "${userRepository.userModel!.profilePic ?? authController.user!.photoURL}")
                              as ImageProvider,
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
                Text(
                  nameTextController.text,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                CustomTextfeild(
                  textEditingController: nameTextController,
                  prefixIcon: Icons.person,
                ),
                CustomTextfeild(
                  textEditingController: emailTextController,
                  prefixIcon: Icons.email,
                  readOnly: userRepository.userModel!.authType == "google",
                ),
                CustomTextfeild(
                  textEditingController: phoneTextController,
                  prefixIcon: Icons.phone,
                ),
                // CustomTextfeild(
                //   textEditingController: textEditingController,
                //   prefixIcon: Icons.lock,
                // ),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                if (imagePath != null) {
                  try {
                    Reference ref =
                        referenceRoot.child(DateTime.now().toIso8601String());
                    await ref.putFile(File(imagePath!));

                    imageUrl = await ref.getDownloadURL();
                    PLog.yellow(imageUrl ?? "faild");
                    if (imageUrl != null) {
                      imagePath = null;
                    }
                    setState(() {});
                  } catch (error) {}
                }
                await userRepository.updateUser(UserModel(
                  id: userRepository.userModel!.id,
                  authType: userRepository.userModel!.authType,
                  fullName: nameTextController.text,
                  phoneNo: phoneTextController.text,
                  email: userRepository.userModel!.email,
                  profilePic: imageUrl ?? userRepository.userModel!.profilePic,
                ));
                PLog.yellow(userRepository.userModel!.toString());
              },
              child: Text("Save")),
        ),
      );
    });
  }
}
