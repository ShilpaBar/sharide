import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sharide/models/user_model.dart';
import 'package:sharide/repository/user_repository.dart';
import 'authentication/google_signin.dart';
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
  AuthenticationContoller authenticationController =
      Get.find<AuthenticationContoller>();

  // @override
  // void initState() {
  //   Get.delete<GoogleSignInContoller>();
  //   googleSignInContoller = Get.find<GoogleSignInContoller>();
  //   super.initState();
  // }
  UserRepository userRepository = Get.find<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationContoller>(builder: (_) {
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
                style: TextStyle(fontSize: 23),
              ),
            ),
            Divider(
              color: Color(0xFF999999),
              height: 50,
              indent: 20,
              endIndent: 20,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final userCred =
                    await authenticationController.signInWithGoogle();
                authenticationController.update();
                if (userCred != null) {
                  final x = authenticationController.user!.providerData[0].uid!;
                  userRepository.createUser(UserModel(
                      id: x,
                      fullName:
                          authenticationController.user!.displayName ?? "",
                      authType: authenticationController
                                  .user!.providerData[0].providerId ==
                              "google.com"
                          ? "google"
                          : "phone",
                      phoneNo: authenticationController.user!.phoneNumber ?? "",
                      email: authenticationController.user!.email ?? "",
                      profilePic:
                          authenticationController.user!.photoURL ?? ""));
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavigationScreen(),
                      ),
                      (r) => false);
                }
              },
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
    });
  }
}
