import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sharide/authentication/google_signin.dart';
import 'package:sharide/home/bottom_nav_screen.dart';
import 'package:sharide/models/user_model.dart';
import 'package:sharide/otp_screen.dart';

import 'widgets/custom_textfeild.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController phoneNumberTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationContoller>(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Sharide"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 40),
                ),
              ),
              Text(
                "Please register your account to sign in",
                style: TextStyle(fontSize: 16, color: Color(0xFF999999)),
              ),
              CustomTextfeild(
                prefixIcon: Icons.person,
                labelText: "Full name",
              ),
              CustomTextfeild(
                prefixIcon: Icons.email,
                labelText: "Email address",
              ),
              CustomTextfeild(
                prefixIcon: Icons.lock,
                labelText: "Password",
                isPassword: true,
              ),
              CustomTextfeild(
                textEditingController: phoneNumberTextController,
                prefixIcon: Icons.phone,
                labelText: "Phone number",
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xFF009963)),
                      ))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
