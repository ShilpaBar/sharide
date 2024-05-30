import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({super.key});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  List<StepperData> stepperData = [
    StepperData(
      title: StepperText("Hawrah",
          textStyle: TextStyle(color: Colors.white, fontSize: 19)),
      subtitle: StepperText("Around 12:04",
          textStyle: TextStyle(fontSize: 15, color: Color(0xFFAFA8A8))),
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
      title: StepperText("Sector V",
          textStyle: TextStyle(color: Colors.white, fontSize: 19)),
      subtitle: StepperText("Around 01:04",
          textStyle: TextStyle(fontSize: 15, color: Color(0xFFAFA8A8))),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Go"),
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
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 45,
                            width: 160,
                            padding: EdgeInsets.only(left: 17, top: 10),
                            child: Text(
                              "45 Minutes",
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
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 45,
                            width: 150,
                            padding: EdgeInsets.only(left: 17, top: 10),
                            child: Text(
                              "123.34",
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
                        style: TextStyle(fontSize: 17),
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
                  Container(
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
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
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
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
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
