import 'package:flutter/material.dart';
import 'package:sharide/widgets/history_list_tile.dart';

class MyTrips extends StatefulWidget {
  const MyTrips({super.key});

  @override
  State<MyTrips> createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My trips"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => HistoryListTile(),
        ));
  }
}
