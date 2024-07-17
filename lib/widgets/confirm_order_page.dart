import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sharide/models/rides_model.dart';
import 'package:upi_india/upi_india.dart';
import 'package:uuid/uuid.dart';

class ConfirmOrderPage extends StatefulWidget {
  final RidesModel ridesModel;
  const ConfirmOrderPage({super.key, required this.ridesModel});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  List<StepperData> stepperData = [];
  final UpiIndia _upiIndia = UpiIndia();
  UpiResponse? _transaction;
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    String refId = DateTime.now().toIso8601String();
    PLog.red(refId);
    return _upiIndia.startTransaction(
        app: app,
        receiverUpiId: "subhabratadash2-3@okicici",
        receiverName: "Subhabrata Das",
        transactionRefId: refId,
        amount: widget.ridesModel.price!);
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (apps!.isEmpty) {
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () async {
                  _transaction = await initiateTransaction(app);
                  if (mounted) Navigator.pop(context);
                  setState(() {});
                  if (_transaction != null) {
                    PLog.red("${_transaction!.status}");
                  }
                  _transaction != null
                      ? _transaction!.status == "submitted" ||
                              _transaction!.status == "successful"
                          ? QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              animType: QuickAlertAnimType.slideInUp,
                              barrierDismissible: false,
                              backgroundColor:
                                  Theme.of(context).dialogBackgroundColor,
                              title: "Order Submitted!",
                              titleColor: Colors.white,
                              text: "Thank you for your order",
                              textColor: Theme.of(context).primaryColorLight,
                              confirmBtnText: "Order Submitted",
                              confirmBtnColor: Color.fromARGB(255, 2, 13, 9),
                            )
                          : QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              animType: QuickAlertAnimType.slideInUp,
                              barrierDismissible: false,
                              backgroundColor:
                                  Theme.of(context).dialogBackgroundColor,
                              title: "Order Failed!",
                              titleColor: Colors.white,
                              text: "Your payment has been failed",
                              textColor: Theme.of(context).primaryColorLight,
                              confirmBtnText: "Payment Failed",
                              // confirmBtnColor: Color(0xFF009963),
                            )
                      : QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          animType: QuickAlertAnimType.slideInUp,
                          barrierDismissible: false,
                          backgroundColor:
                              Theme.of(context).dialogBackgroundColor,
                          title: "Order Cancelled",
                          titleColor: Colors.white,
                          text: "You have cancelled your transaction!",
                          textColor: Theme.of(context).primaryColorLight,
                          confirmBtnText: "Order Cancelled",
                          confirmBtnColor: Color(0xFF009963),
                        );
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

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
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      print(e);
      apps = [];
    });
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
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     height: 50,
                  //     width: 360,
                  //     padding: EdgeInsets.only(left: 10, right: 10),
                  //     decoration: BoxDecoration(
                  //       color: Color(0xFF2E2E2E),
                  //       border: Border.all(
                  //         color: Color(0xFFAFA8A8),
                  //       ),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           Icons.credit_card,
                  //           color: Colors.white54,
                  //         ),
                  //         Text(
                  //           "  Add payment method",
                  //           style: TextStyle(fontSize: 14),
                  //         ),
                  //         Spacer(),
                  //         Icon(Icons.arrow_forward_ios)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          builder: (BuildContext context) {
                            return displayUpiApps();
                          });
                      // AwesomeDialog(
                      //   context: context,
                      //   dialogType: DialogType.success,
                      //   animType: AnimType.bottomSlide,
                      //   title: "Order Successful!",
                      //   desc: "Thank you for your order",
                      //   btnOkOnPress: () {},
                      // ).show();
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
