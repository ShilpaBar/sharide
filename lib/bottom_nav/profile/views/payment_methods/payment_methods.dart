import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sharide/bottom_nav/activity/ride_history_screen.dart';
import 'package:sharide/bottom_nav/profile/views/payment_methods/add_payment_method.dart';
import 'package:sharide/models/payments_model.dart';
import 'package:sharide/repository/user_repository.dart';
import 'package:sharide/widgets/custom_textfeild.dart';
import 'package:sharide/widgets/payment_list_tile.dart';
import 'package:grouped_list/grouped_list.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

UserRepository useRepo = Get.find<UserRepository>();

class _PaymentMethodsState extends State<PaymentMethods> {
  TextEditingController bankNameTextController = TextEditingController();
  TextEditingController branchNameTextController = TextEditingController();
  TextEditingController accNumTextController = TextEditingController();
  TextEditingController ifscCodeTextController = TextEditingController();
  TextEditingController accHoldernameTextController = TextEditingController();
  TextEditingController upiIdTextController = TextEditingController();
  UserRepository userRepository = Get.find<UserRepository>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userRepo.setPaymentMethodRef(useRepo.userModel!.phoneNo);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Methods",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Gap(25),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillingDetails(),
                    ));
              },
              label: Text(
                "Add Payment Method",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
              icon: Icon(
                Icons.add,
                size: 33,
              ),
              style: OutlinedButton.styleFrom(
                  iconColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  fixedSize: Size(370, 55),
                  side: BorderSide(color: Colors.white, width: 2.0)),
            ),
            Divider(
              color: Color(0xFF999999),
              height: 70,
            ),
            GetBuilder<UserRepository>(builder: (paymentUserRepo) {
              return Expanded(
                child: StreamBuilder<QuerySnapshot<PaymentsModel>>(
                  stream: paymentUserRepo.paymentDb?.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text("No payment method has been added"),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              PaymentsModel data =
                                  snapshot.data!.docs[index].data();
                              return PaymentListTile(
                                data: data,
                              );
                            });
                      }
                    } else {
                      return Gap(10);
                    }
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
