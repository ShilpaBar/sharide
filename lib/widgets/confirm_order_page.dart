import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sharide/models/rides_model.dart';
import 'package:sharide/upi_payment_screen.dart';

class ConfirmOrderPage extends StatefulWidget {
  final RidesModel ridesModel;
  const ConfirmOrderPage({super.key, required this.ridesModel});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  List<StepperData> stepperData = [];
  @override
  void initState() {
    stepperData = [
      StepperData(
        title: StepperText("${widget.ridesModel.location}",
            textStyle: TextStyle(color: Colors.white, fontSize: 14)),
        subtitle: StepperText("${widget.ridesModel.date}",
            textStyle: TextStyle(fontSize: 12, color: Color(0xFFAFA8A8))),
        iconWidget: Container(
          padding: EdgeInsets.all(1.8),
          decoration: BoxDecoration(
            color: Color(0xFF009963),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Icon(
            Icons.circle,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
      StepperData(
        title: StepperText("${widget.ridesModel.destination}",
            textStyle: TextStyle(color: Colors.white, fontSize: 14)),
        subtitle: StepperText("Around 01:04",
            textStyle: TextStyle(fontSize: 12, color: Color(0xFFAFA8A8))),
        iconWidget: Container(
          padding: EdgeInsets.all(1.8),
          decoration: BoxDecoration(
            color: Color(0xFF009963),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Icon(
            Icons.circle,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.ridesModel.transportType}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage("assets/images/map.png"),
              height: 270,
              fit: BoxFit.fitHeight,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  AnotherStepper(
                    stepperList: stepperData,
                    inActiveBarColor: Color(0xFF009963),
                    stepperDirection: Axis.vertical,
                    iconHeight: 27,
                    iconWidth: 27,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time),
                              Text(
                                "  Travel Time",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 45,
                            width: 130,
                            padding: EdgeInsets.only(left: 17, top: 10),
                            child: Text(
                              "${widget.ridesModel.duration}",
                              style: TextStyle(fontSize: 15),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                border: Border.all(color: Color(0xFFAFA8A8))),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                size: 21,
                              ),
                              Text(
                                " Price",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 45,
                            width: 130,
                            padding: EdgeInsets.only(left: 17, top: 10),
                            child: Text(
                              "${widget.ridesModel.price}",
                              style: TextStyle(fontSize: 15),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                border: Border.all(color: Color(0xFFAFA8A8))),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(Icons.text_snippet_outlined),
                      Text(
                        "  Notes to Driver",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFAFA8A8)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpiPaymentScreen(),
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: 360,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF2E2E2E),
                        border: Border.all(
                          color: Color(0xFFAFA8A8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Colors.white54,
                          ),
                          Text(
                            "  Add payment method",
                            style: TextStyle(fontSize: 14),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // AwesomeDialog(
                      //   context: context,
                      //   dialogType: DialogType.success,
                      //   animType: AnimType.bottomSlide,
                      //   title: "Order Successful!",
                      //   desc: "Thank you for your order",
                      //   btnOkOnPress: () {},
                      // ).show();

                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        animType: QuickAlertAnimType.slideInUp,
                        barrierDismissible: false,
                        backgroundColor:
                            Theme.of(context).dialogBackgroundColor,
                        title: "Order Successful!",
                        titleColor: Colors.white,
                        text: "Thank you for your order",
                        textColor: Theme.of(context).primaryColorLight,
                        confirmBtnText: "Order Status",
                        confirmBtnColor: Color(0xFF009963),
                      );
                    },
                    child: Text(
                      "ORDER YOUR RIDE",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
