import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sharide/bottom_nav/profile/views/settings/notification_page.dart';
import 'package:sharide/widgets/settings_list_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Gap(20),
            Text(
              "GENERAL",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Gap(15),
            settingsListTile(
                title: "Notification",
                icon: Icons.notifications_none_outlined,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationPage(),
                      ));
                }),
            settingsListTile(
                title: "Language", icon: Icons.language_outlined, onTap: () {}),
            settingsListTile(
                title: "App updates",
                icon: Icons.mobile_friendly,
                onTap: () {}),
            settingsListTile(
                title: "About", icon: Icons.help_outline, onTap: () {}),
            Gap(25),
            Text(
              "FEEDBACK",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Gap(15),
            settingsListTile(
                title: "Report a bug", icon: Icons.error_outline, onTap: () {}),
            settingsListTile(
                title: "Send feedback",
                icon: Icons.send_outlined,
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
