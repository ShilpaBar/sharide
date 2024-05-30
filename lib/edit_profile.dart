import 'package:flutter/material.dart';
import 'package:sharide/widgets/custom_textfeild.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController textEditingController =
      TextEditingController(text: "Shilpa Bar");
  @override
  Widget build(BuildContext context) {
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
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
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
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                textEditingController.text,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              CustomTextfeild(
                textEditingController: textEditingController,
                prefixIcon: Icons.person,
              ),
              CustomTextfeild(
                textEditingController: textEditingController,
                prefixIcon: Icons.email,
              ),
              CustomTextfeild(
                textEditingController: textEditingController,
                prefixIcon: Icons.phone,
              ),
              CustomTextfeild(
                textEditingController: textEditingController,
                prefixIcon: Icons.lock,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
