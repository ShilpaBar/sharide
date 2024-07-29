import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:sharide/repository/user_repository.dart';

import '../onboarding/otp_screen.dart';
import '../onboarding/signin_page.dart';

class AuthenticationContoller extends GetxController {
  UserRepository userRepo = Get.put(UserRepository());
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUser();
      if (user != null) {
        await userRepo.getUser(user!.uid);
        PLog.green("${userRepo.userModel!.toJson()}");
      }
    });
  }

  getUser() {
    user = firebaseAuth.currentUser;
    PLog.green("${user}");

    update();
  }

  bool isLoading = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    isLoading = true;
    update();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    debugPrint("##################${userCredential.user!.displayName}");
    user = userCredential.user;
    isLoading = false;
    update();
    // Once signed in, return the UserCredential
    return userCredential;
  }

  String? otp;

  sendOtp(
    TextEditingController phoneNumberTextController,
  ) async {
    isLoading = true;
    update();
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91${phoneNumberTextController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        PLog.red("${credential}");
      },
      verificationFailed: (FirebaseAuthException e) {
        PLog.error("phone verification failed: $e");
        Get.snackbar("Error", "${e.toString().split("] ").last}",
            backgroundGradient: LinearGradient(
                colors: [Colors.red, Colors.redAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(20));
      },
      codeSent: (String vId, int? resendToken) {
        otp = vId;
        update();
      },
      codeAutoRetrievalTimeout: (String vId) {
        otp = vId;
        update();
      },
      timeout: Duration.zero,
    );
    // return verificationId != null;
  }

  Future<UserCredential?> verifyOtp(TextEditingController smsController) async {
    isLoading = true;
    update();
    UserCredential? userCredential;
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: otp!,
        smsCode: smsController.text,
      );
      if (credential.isBlank != null && credential.isBlank != true) {
        userCredential = await firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      Get.snackbar("Error", "${e.toString().split("] ").last}",
          backgroundGradient: LinearGradient(
              colors: [Colors.red, Colors.redAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20));
      PLog.error(e.toString());
    }
    isLoading = false;
    update();

    otp = null;
    PLog.success("${userCredential}");
    return userCredential;
  }

  Future<void> signOut(BuildContext context) async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
    user = null;
    update();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ),
        (route) => false);
  }
}
