import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryListTile extends StatefulWidget {
  final String pickUpLocation;
  final String dropLocation;
  final DateTime? dateTime;
  final double? charge;
  const HistoryListTile(
      {super.key,
      this.pickUpLocation = "XYZ",
      this.dropLocation = "XYZ",
      this.dateTime,
      this.charge});

  @override
  State<HistoryListTile> createState() => _HistoryListTileState();
}

class _HistoryListTileState extends State<HistoryListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Pickup : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        widget.pickUpLocation.isEmpty
                            ? "N/A"
                            : widget.pickUpLocation,
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Dropoff : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        widget.dropLocation.isEmpty
                            ? "N/A"
                            : widget.dropLocation,
                        style: TextStyle(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${DateFormat('MMM d, yyyy - h:mma').format(
                    widget.dateTime ?? DateTime.now(),
                  )}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Rs.${widget.charge ?? "00"}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
