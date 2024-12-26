import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharide/models/payments_model.dart';
import 'package:sharide/repository/user_repository.dart';

class PaymentListTile extends StatefulWidget {
  final PaymentsModel data;
  final Function()? onTap;
  const PaymentListTile({super.key, required this.data, this.onTap});

  @override
  State<PaymentListTile> createState() => _PaymentListTileState();
}

class _PaymentListTileState extends State<PaymentListTile> {
  UserRepository userRepository = Get.find<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            childrenPadding: EdgeInsets.only(left: 60),
            expandedAlignment: Alignment.centerLeft,
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.payment,
                size: 30,
              ),
              title: Text(
                widget.data.isUpi ? "UPI" : "Bank",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: InkWell(
                child: Icon(
                  Icons.delete_outlined,
                  size: 30,
                ),
                onTap: () async {
                  try {
                    await userRepository.paymentDb!
                        .doc(widget.data.accNo)
                        .delete();
                  } catch (e) {
                    print('Error deleting item: $e');
                  }
                },
              ),
              onTap: widget.onTap,
            ),
            children: [
              Text(
                widget.data.isUpi
                    ? widget.data.accNo
                    : "${widget.data.bankName}, ${widget.data.branchName}, ${widget.data.accNo}, ${widget.data.ifscCode}, ${widget.data.accHolderName}",
                style: TextStyle(fontSize: 18, color: Color(0xFFAFA8A8)),
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xFF999999),
          thickness: 0.25,
          indent: 45,
        ),
      ],
    );
  }
}
