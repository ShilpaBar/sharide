import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'forgot_pw_page.dart';
import 'home/bottom_nav_screen.dart';
import 'signup_page.dart';
import 'widgets/custom_textfeild.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Sharide"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text(
              "SIGN IN",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Text(
            "Please sign in your account to get started!",
            style: TextStyle(fontSize: 16, color: Color(0xFFAFA8A8)),
          ),
          CustomTextfeild(
            labelText: "Enter email address",
          ),
          CustomTextfeild(
            prefixIcon: Icons.lock,
            labelText: "Enter password",
            isPassword: true,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF009963),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavigationScreen(),
                ),
              );
            },
            child: Text(
              "SIGN IN",
              // style: TextStyle(fontSize: 25),
            ),
            // style: ElevatedButton.styleFrom(
            //   foregroundColor: Colors.white,
            //   fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width - 40),
            // ),
          ),
          Divider(
            color: Color(0xFF999999),
            height: 50,
            indent: 20,
            endIndent: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: LottieBuilder.asset(
              "assets/lotties/google.json",
              height: 40,
              frameRate: FrameRate.max,
            ),
            label: Text(
              "Sign in with Google",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E2E2E),
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
                "Don't have an account? ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 17, color: Color(0xFF009963)),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
