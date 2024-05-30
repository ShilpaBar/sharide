import 'package:flutter/material.dart';
import 'package:sharide/widgets/confirm_order_page.dart';
import 'package:sharide/widgets/rides_list_tile.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose a ride",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.separated(
                itemCount: 15,
                separatorBuilder: (context, index) => SizedBox(
                  height: 7,
                ),
                itemBuilder: (context, index) => RidesListTile(
                  image: "assets/images/Auto.png",
                  title: "Car Go",
                  seats: 4,
                  description: "Affordable, compact rides",
                  price: "120.34",
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmOrderPage(),
            ),
          );
        },
        child: Text(
          "Choose",
          style: TextStyle(fontSize: 23),
        ),
      ),
    );
  }
}
