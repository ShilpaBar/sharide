import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RidesListTile extends StatefulWidget {
  final String? image;
  final String? title;
  final int? seats;
  final DateTime? time;
  final String? description;
  final String? price;
  final bool? selected;

  const RidesListTile({
    super.key,
    this.image,
    this.title,
    this.seats,
    this.time,
    this.description,
    this.price,
    this.selected,
  });

  @override
  State<RidesListTile> createState() => _RidesListTileState();
}

class _RidesListTileState extends State<RidesListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      // leading: Image(
      //   image: AssetImage(widget.image!),
      // ),
      title: Row(
        children: [
          Text(
            widget.title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.person,
            size: 18,
          ),
          Text("${widget.seats}"),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${DateFormat('h:mma').format(widget.time ?? DateTime.now())}"),
          Text(
            widget.description!,
            style: TextStyle(
                color: Color.fromARGB(255, 161, 154, 154), fontSize: 13),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.currency_rupee,
            size: 16,
          ),
          Text(
            widget.price ?? "",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      onTap: () {
        // setState(
        //   () {
        //     if (widget.selected) {}
        //   },
        // );
      },
    );
  }
}
