import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:sharide/repository/user_repository.dart';

import '../signin_page.dart';

class AuthenticationContoller extends GetxController {
  UserRepository userRepo = Get.put(UserRepository());
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUser();
      if (user != null) {
        await userRepo.getUser(user!.providerData[0].uid!);
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

  Future<UserCredential?> signInwithPhone(
      TextEditingController phoneNumberTextController) async {
    String? _verificationId;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumberTextController.text,
      verificationCompleted: (PhoneAuthCredential credential) {
        firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        update();
      },
      timeout: Duration(seconds: 30),
    );
    // if(_verificationId!=null){

    // final PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //   verificationId: _verificationId!,
    //   smsCode: _smsController.text,
    // );
    // }
    // UserCredential userCredential =
    // await firebaseAuth.signInWithCredential(credential);
    // debugPrint("##################${userCredential.user!.displayName}");
    // user = userCredential.user;
    isLoading = false;
    update();
    // Once signed in, return the UserCredential
    // return userCredential;
    return null;
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
