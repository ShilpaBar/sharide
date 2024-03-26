import 'package:flutter/material.dart';

import 'signin_page.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 23, 23, 23),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            //     child: Image(
            //   image: AssetImage("assets/pngwing.com (2).png"),
            // )),
            Text(
              "Sharide",
              style: textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Rent Your Vehicles & Earn Extra Money",
              style: textTheme.titleSmall!,
            ),
            SizedBox(
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ));
              },
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
