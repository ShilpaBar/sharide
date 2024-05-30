import 'package:flutter/material.dart';
import 'package:sharide/edit_profile.dart';
import 'package:sharide/signin_page.dart';
import 'package:sharide/widgets/profile_menu.dart';

import '../../models/profile_items_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<ProfileItemsModel> profileItemsModelList = [
    ProfileItemsModel(title: "Settings", leading: Icons.settings_outlined),
    ProfileItemsModel(
        title: "Billing Details",
        leading: Icons.account_balance_wallet_outlined),
    ProfileItemsModel(
        title: "Privacy Policy", leading: Icons.privacy_tip_outlined),
    ProfileItemsModel(title: "Help & Support", leading: Icons.help_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ),
              );
            },
            icon: Icon(
              Icons.logout,
              color: Color(0xFF009963),
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Shilpa Bar",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "shilpaBar0@gmail.com",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  );
                },
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              ...List.generate(
                profileItemsModelList.length,
                (index) => ProfileMenu(
                    title: profileItemsModelList[index].title,
                    icon: profileItemsModelList[index].leading),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
