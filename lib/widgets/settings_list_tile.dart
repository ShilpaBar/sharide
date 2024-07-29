import 'package:flutter/material.dart';

class settingsListTile extends StatelessWidget {
  const settingsListTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        // color: Colors.white,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
