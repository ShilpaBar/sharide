import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharide/authentication/google_signin.dart';
import 'package:sharide/firebase_options.dart';
import 'package:sharide/front_page.dart';
import 'package:sharide/location/locationhelper.dart';
import 'package:sharide/otp_screen.dart';
import 'package:sharide/repository/user_repository.dart';

import 'repository/rides_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.lazyPut(() => LocationController());
  Get.put(AuthenticationContoller());
  Get.put(UserRepository());
  Get.put(RidesRepository());

  runApp(const MyApp());
}

final snackKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: snackKey,
      debugShowCheckedModeBanner: false,
      title: "Sharide",
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.inriaSerifTextTheme(),
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            backgroundColor: Color(0xFF009963),
            foregroundColor: Colors.white,
            fixedSize: Size.fromWidth(MediaQuery.of(context).size.width * .9),
            textStyle:
                GoogleFonts.inriaSerifTextTheme(Typography.whiteCupertino)
                    .headlineLarge,
          ),
        ),
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
        textTheme: GoogleFonts.inriaSerifTextTheme(Typography.whiteCupertino),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
        ),
      ),
      home: FrontPage(),
    );
  }
}
