import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
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
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 49, 58, 48),
        child: Icon(
          icon,
          color: Color(0xFF009963),
          size: 27,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      trailing: CircleAvatar(
        radius: 17,
        backgroundColor: Color(0xFF2E2E2E),
        child: Icon(
          Icons.arrow_forward_ios,
          size: 20,
        ),
      ),
      onTap: onTap,
    );
  }
}
