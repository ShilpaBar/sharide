import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:sharide/models/user_model.dart';
import 'package:sharide/onboarding/otp_screen.dart';
import 'package:sharide/repository/user_repository.dart';
import '../authentication/authentication.dart';
import '../bottom_nav/bottom_nav_screen.dart';
import 'signup_page.dart';
import '../widgets/custom_textfeild.dart';

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
  final formKey = GlobalKey<FormState>();
  UserRepository userRepository = Get.find<UserRepository>();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController otpTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(fontSize: 22),
      decoration: BoxDecoration(
        color: Color(0xFF2E2E2E),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return GetBuilder<AuthenticationContoller>(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Sharide"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                Gap(50),
                Text(
                  "Please sign in your account to get started!",
                  style: TextStyle(fontSize: 16, color: Color(0xFFAFA8A8)),
                ),
                CustomTextfeild(
                  labelText: "Enter phone number",
                  prefixIcon: Icons.phone,
                  textEditingController: phoneTextController,
                  keyboardType: TextInputType.phone,
                  validator: (p0) => p0!.isEmpty
                      ? "Please enter your phone number ."
                      : p0.length < 10 || p0.length > 14
                          ? "Phone number is not valid ."
                          : null,
                ),
                // CustomTextfeild(
                //   prefixIcon: Icons.lock,
                //   labelText: "Enter password",
                //   isPassword: true,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       TextButton(
                //           onPressed: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => ForgotPasswordPage(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             "Forgot password?",
                //             style: TextStyle(
                //               fontSize: 16,
                //               color: Color(0xFF009963),
                //             ),
                //           )),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                if (authenticationController.otp != null) ...[
                  Text(
                    "Verification code",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Pinput(
                    controller: otpTextController,
                    length: 6,
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(
                          color: Color(0xFF009963),
                        ),
                      ),
                    ),
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    validator: (value) => value!.isEmpty
                        ? "Please enter OTP ."
                        : value.length < 6
                            ? "OTP must be 6 digit ."
                            : null,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Color(0xFF999999),
                    height: 50,
                  ),
                ],

                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      UserModel? userModel = await userRepository
                          .getUser(phoneTextController.text);
                      if (userModel == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SignUpPage(phoneNo: phoneTextController.text),
                          ),
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationScreen(),
                            ),
                            (r) => false);
                      }

                      // if (authenticationController.otp == null) {
                      //   await authenticationController.sendOtp(
                      //     phoneTextController,
                      //   );
                      // } else {
                      //   UserCredential? userCred =
                      //       await authenticationController
                      //           .verifyOtp(otpTextController);
                      //   if (userCred != null) {
                      //     UserModel? userModel = await userRepository
                      //         .getUser(phoneTextController.text);
                      //     if (userModel == null) {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => SignUpPage(),
                      //         ),
                      //       );
                      //     } else {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => BottomNavigationScreen(),
                      //         ),
                      //       );
                      //     }
                      //   }
                      // }
                    }
                  },
                  child: Text(
                    authenticationController.otp == null
                        ? "SEND OTP"
                        : "SIGN IN",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                Divider(
                  color: Color(0xFF999999),
                  height: 50,
                ),
                Gap(50),

                // ElevatedButton.icon(
                //   onPressed: () async {
                //     final userCred =
                //         await authenticationController.signInWithGoogle();
                //     authenticationController.update();
                //     if (userCred != null) {
                //       final x =
                //           authenticationController.user!.providerData[0].uid!;
                //       userRepository.createUser(UserModel(
                //           fullName:
                //               authenticationController.user!.displayName ?? "",
                //           phoneNo: authenticationController.user!.email ?? "",
                //           email: authenticationController.user!.email ?? "",
                //           profilePic:
                //               authenticationController.user!.photoURL ?? ""));
                //       if (!mounted) return;
                //       Navigator.pushAndRemoveUntil(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => BottomNavigationScreen(),
                //           ),
                //           (r) => false);
                //     }
                //   },
                //   icon: LottieBuilder.asset(
                //     "assets/lotties/google.json",
                //     height: 40,
                //     frameRate: FrameRate.max,
                //   ),
                //   label: Text(
                //     "Sign in with Google",
                //     style: TextStyle(
                //       fontSize: 17,
                //     ),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xFF2E2E2E),
                //   ),
                // ),
                // Divider(
                //   color: Color(0xFF999999),
                //   height: 70,
                //   indent: 20,
                //   endIndent: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Don't have an account? ",
                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //     ),
                //     TextButton(
                //         onPressed: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => SignUpPage(),
                //               ));
                //         },
                //         child: Text(
                //           "Register",
                //           style: TextStyle(fontSize: 17, color: Color(0xFF009963)),
                //         ))
                //   ],
                // )
              ],
            ),
          ),
        ),
      );
    });
  }
}
