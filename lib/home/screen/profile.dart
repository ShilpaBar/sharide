import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharide/edit_profile.dart';
import 'package:sharide/repository/user_repository.dart';
import 'package:sharide/widgets/profile_menu.dart';
import '../../authentication/google_signin.dart';
import '../../models/profile_items_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserRepository userRepository = Get.find<UserRepository>();

  AuthenticationContoller authController = Get.find<AuthenticationContoller>();

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
    return GetBuilder<UserRepository>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await authController.signOut(context);
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
                  backgroundImage: NetworkImage(
                      "${userRepository.userModel!.profilePic ?? authController.user!.photoURL}"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${userRepository.userModel!.fullName}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${userRepository.userModel!.email}",
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
    });
  }
}
