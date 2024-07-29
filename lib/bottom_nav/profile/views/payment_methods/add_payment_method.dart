import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sharide/models/payments_model.dart';
import 'package:sharide/repository/user_repository.dart';
import 'package:sharide/widgets/custom_textfeild.dart';

class BillingDetails extends StatefulWidget {
  BillingDetails({super.key});

  @override
  State<BillingDetails> createState() => _BillingDetailsState();
}

class _BillingDetailsState extends State<BillingDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // TextEditingController phNoController=TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController ifcCodeController = TextEditingController();
  TextEditingController accHolderNameController = TextEditingController();
  UserRepository userRepository = Get.find<UserRepository>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // bool isUpi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Payment Method",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Gap(8),
            Text(
              "Complete your perchase by providing your payment details.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Gap(25),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 53, 53, 53),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.white,
                    // labelPadding: EdgeInsets.symmetric(horizontal: 30),
                    padding: EdgeInsets.all(5),
                    indicator: BoxDecoration(
                      color: Color(0xFF009963),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    tabAlignment: TabAlignment.fill,
                    controller: tabController,
                    dividerHeight: 0,
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23),
                          child: Text("Bank account"),
                        ),
                      ),
                      Tab(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text("UPI account")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(13),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ListView(
                    children: [
                      CustomTextfeild(
                        textEditingController: bankNameController,
                        prefixIcon: Icons.account_balance,
                        hintText: "Bank name",
                      ),
                      CustomTextfeild(
                        textEditingController: branchNameController,
                        prefixIcon: Icons.comment_bank,
                        hintText: "Branch name",
                      ),
                      CustomTextfeild(
                        textEditingController: accountNumberController,
                        prefixIcon: Icons.account_balance,
                        hintText: "Account number",
                      ),
                      CustomTextfeild(
                        textEditingController: ifcCodeController,
                        prefixIcon: Icons.pin,
                        hintText: "IFSC code",
                      ),
                      CustomTextfeild(
                        textEditingController: accHolderNameController,
                        prefixIcon: Icons.person,
                        hintText: "Account holder name",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const CustomTextfeild(
                        prefixIcon: Icons.payment,
                        hintText: "UPI id",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ChoiceChip(
            //       label: const Text(
            //         "Bank account",
            //         style: TextStyle(color: Colors.white, fontSize: 15),
            //       ),
            //       selectedColor: Color(0xFF009963),
            //       selected: !isUpi,
            //       onSelected: (_) {
            //         isUpi = false;
            //         setState(() {});
            //       },
            //     ),
            //     ChoiceChip(
            //       label: const Text(
            //         "UPI account",
            //         style: TextStyle(color: Colors.white, fontSize: 15),
            //       ),
            //       selectedColor: Color(0xFF009963),
            //       selected: isUpi,
            //       onSelected: (_) {
            //         isUpi = true;
            //         setState(() {});
            //       },
            //     )
            //   ],
            // ),
            // if (!isUpi) ...[
            //   const CustomTextfeild(
            //     prefixIcon: Icons.account_balance,
            //     hintText: "Bank name",
            //   ),
            //   const CustomTextfeild(
            //     prefixIcon: Icons.comment_bank,
            //     hintText: "Branch name",
            //   ),
            //   const CustomTextfeild(
            //     prefixIcon: Icons.account_balance,
            //     hintText: "Bank account number",
            //   ),
            //   const CustomTextfeild(
            //     prefixIcon: Icons.pin,
            //     hintText: "IFSC code",
            //   ),
            //   const CustomTextfeild(
            //     prefixIcon: Icons.person,
            //     hintText: "Account holder name",
            //   ),
            // ],
            // if (isUpi) ...[
            //   const CustomTextfeild(
            //     prefixIcon: Icons.payment,
            //     hintText: "UPI id",
            //   ),
            // ],
            ElevatedButton(
                onPressed: () async {
                  await userRepository.createPayMethod(
                    userRepository.userModel!.phoneNo,
                    PaymentsModel(
                      accNo: accountNumberController.text,
                      bankName: bankNameController.text,
                      branchName: branchNameController.text,
                      ifscCode: ifcCodeController.text,
                      accHolderName: accHolderNameController.text,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  "Done",
                  style: TextStyle(fontSize: 26),
                )),
          ],
        ),
      ),
    );
  }
}
