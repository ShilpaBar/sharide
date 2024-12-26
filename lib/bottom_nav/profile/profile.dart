import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharide/bottom_nav/profile/views/payment_methods/add_payment_method.dart';
import 'package:sharide/bottom_nav/profile/views/edit_profile.dart';
import 'package:sharide/bottom_nav/profile/views/payment_methods/payment_methods.dart';
import 'package:sharide/bottom_nav/profile/views/settings/settings_page.dart';
import 'package:sharide/repository/user_repository.dart';
import 'package:sharide/widgets/profile_menu.dart';
import '../../authentication/authentication.dart';
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
        title: "Payment Methods",
        leading: Icons.account_balance_wallet_outlined),
    ProfileItemsModel(
        title: "Privacy Policy", leading: Icons.privacy_tip_outlined),
    ProfileItemsModel(
        title: "Help & Support", leading: Icons.question_answer_outlined),
  ];
  // List<VoidCallback> onTapFunction =
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserRepository>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Log out"),
                    content: Text("Do you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await authController.signOut(context);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Color(0xFF009963),
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
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
            padding: EdgeInsets.all(45),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                      "${userRepository.userModel!.profilePic ?? "https://cdn-icons-png.flaticon.com/128/4140/4140048.png"}"),
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
                  height: 45,
                ),
                ...List.generate(
                  profileItemsModelList.length,
                  (index) => ProfileMenu(
                    title: profileItemsModelList[index].title,
                    icon: profileItemsModelList[index].leading,
                    onTap: [
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethods(),
                          ),
                        );
                      },
                      () {},
                      () {}
                    ][index],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
