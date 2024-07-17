import 'package:flutter/material.dart';

import 'widgets/custom_textfeild.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sharide"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Enter your email and we will send you a password reset link",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextfeild(
            labelText: "Email address",
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Reset Password",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
