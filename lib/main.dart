import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharide/front_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            fixedSize: Size.fromWidth(MediaQuery.of(context).size.width * .8),
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
      home: const FrontPage(),
    );
  }
}
