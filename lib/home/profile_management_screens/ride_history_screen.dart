import 'package:flutter/material.dart';
import 'package:sharide/widgets/history_list_tile.dart';

class RideHistoryScreens extends StatefulWidget {
  const RideHistoryScreens({super.key});

  @override
  State<RideHistoryScreens> createState() => _RideHistoryScreensState();
}

class _RideHistoryScreensState extends State<RideHistoryScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rides History"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => HistoryListTile(
            charge: 132,
          ),
        ));
  }
}
