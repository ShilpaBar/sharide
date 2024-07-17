import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sharide/authentication/authentication.dart';
import 'package:sharide/bnb/profile/views/payment_methods/add_payment_method.dart';
import 'package:sharide/location/locationhelper.dart';
import 'package:sharide/models/rides_model.dart';
import 'package:sharide/repository/rides_repository.dart';
import 'package:sharide/repository/user_repository.dart';
import 'package:sharide/rides_screen.dart';
import 'models/vahicles_model.dart';

class ShareRideScreen extends StatefulWidget {
  final bool isBooking;
  const ShareRideScreen({
    super.key,
    this.isBooking = false,
  });

  @override
  State<ShareRideScreen> createState() => _ShareRideScreenState();
}

class _ShareRideScreenState extends State<ShareRideScreen> {
  AuthenticationContoller authController = Get.find<AuthenticationContoller>();

  RidesModel ridesModel = RidesModel();
  TextEditingController destinationTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();
  TextEditingValue locationTextEditingValue = const TextEditingValue();
  // TextEditingController textEditingController = TextEditingController();
  UserRepository userRepo = Get.find<UserRepository>();
  LocationController locationController = Get.find<LocationController>();
  List<String> options = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // getPolyPoints();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await locationController.getMyPosition();

      String? address = await locationController.getAddressFromPosition();
      if (address != null) {
        locationTextController.text = address;
        locationTextEditingValue = TextEditingValue(text: address);
      }
      setState(() {});
    });
  }

  List<VehiclesModel> vehicleList = [
    VehiclesModel(
      name: "Bike",
      icon: "assets/images/motorcycle.png",
    ),
    VehiclesModel(
      name: "Sedan",
      icon: "assets/images/sedan.png",
    ),
    VehiclesModel(
      name: "SUV",
      icon: "assets/images/suv-car.png",
    ),
    VehiclesModel(
      name: "Auto",
      icon: "assets/images/Auto.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (_) {
      return GetBuilder<RidesRepository>(builder: (ridesRepo) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                locationController.myPosition == null
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            Gap(20),
                            Text("Please wait while we fetching your location"),
                          ],
                        ),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          GoogleMap(
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              zoom: 15,
                              target: LatLng(
                                  locationController.myPosition!.latitude,
                                  locationController.myPosition!.longitude),
                            ),
                            onMapCreated: locationController.onMapCreated,
                            markers: {
                              if (locationController.origin != null)
                                locationController.origin!,
                              if (locationController.destination != null)
                                locationController.destination!,
                            },
                            onTap: locationController.addMarker,
                            polylines: locationController.polyLines,
                          ),
                        ],
                      ),
                DraggableScrollableSheet(
                  expand: true,
                  shouldCloseOnMinExtent: true,
                  minChildSize: .3,
                  initialChildSize: .3,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Set your location & destination",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("From"),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Autocomplete(
                                      initialValue: locationTextEditingValue,
                                      onSelected: (address) => setState(() {
                                            locationTextController
                                                .setText(address);
                                            locationController
                                                .setOrigin(address);
                                          }),
                                      fieldViewBuilder: (context, x, y, c) {
                                        // x = locationTextController;
                                        return TextFormField(
                                          controller: x,
                                          onFieldSubmitted: (value) {
                                            c();
                                            setState(() {});
                                          },
                                          focusNode: y,
                                          decoration: InputDecoration(
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF009963),
                                                    width: 2),
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFAFA8A8),
                                                    width: 2),
                                              ),
                                              hintText: locationTextController
                                                      .text.isEmpty
                                                  ? "Your Location"
                                                  : locationTextController
                                                      .text),
                                        );
                                      },
                                      optionsBuilder: (TextEditingValue
                                          textEditingValue) async {
                                        if (textEditingValue.text.isEmpty) {
                                          return const Iterable<String>.empty();
                                        } else {
                                          options = await locationController
                                              .getAddressPrediction(
                                                  textEditingValue.text);
                                          setState(() {});
                                          PLog.red("${options.map((e) => e)}");
                                          return options;
                                        }
                                      }),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("To"),
                            Row(
                              children: [
                                const Icon(
                                  Icons.near_me_rounded,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Autocomplete(
                                      initialValue: TextEditingValue(
                                          text: destinationTextController.text),
                                      onSelected: (option) => setState(() {
                                            destinationTextController
                                                .setText(option);
                                            locationController
                                                .setDestination(option);
                                          }),
                                      fieldViewBuilder: (context,
                                          textController, y, onSubmit) {
                                        return TextFormField(
                                          controller: textController,
                                          onFieldSubmitted: (value) {
                                            onSubmit();
                                            setState(() {});
                                          },
                                          focusNode: y,
                                          decoration: const InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF009963),
                                                    width: 2),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFAFA8A8),
                                                    width: 2),
                                              ),
                                              hintText: "Your Destination"),
                                        );
                                      },
                                      optionsBuilder: (TextEditingValue
                                          textEditingValue) async {
                                        if (textEditingValue.text == '') {
                                          return const Iterable<String>.empty();
                                        } else {
                                          final predictions =
                                              await locationController.places
                                                  .findAutocompletePredictions(
                                                      textEditingValue.text);
                                          options = predictions.predictions
                                              .map((p) => p.fullText)
                                              .toList();
                                          setState(() {});
                                          PLog.red(
                                              "${predictions.predictions.map((e) => e.placeId)}");
                                          return options;
                                        }
                                      }),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E2E2E),
                                borderRadius: BorderRadius.circular(17),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Choose Your Transport:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: vehicleList
                                        .map(
                                          (vehicle) => Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(
                                                children: [
                                                  ChoiceChip(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      shape:
                                                          const CircleBorder(),
                                                      selectedColor:
                                                          const Color(
                                                              0xFF009963),
                                                      onSelected: (value) =>
                                                          setState(() {
                                                            ridesModel
                                                                    .transportType =
                                                                vehicle.name;
                                                            ridesModel.transportType ==
                                                                    "Bike"
                                                                ? locationController.getRoute(
                                                                    travelMode:
                                                                        TravelMode
                                                                            .walking)
                                                                : locationController
                                                                    .getRoute();
                                                          }),
                                                      showCheckmark: false,
                                                      label: Image.asset(
                                                        vehicle.icon,
                                                        color: Colors.white,
                                                        // scale: 3.5,
                                                      ),
                                                      selected: vehicle.name ==
                                                          ridesModel
                                                              .transportType),
                                                  Text(vehicle.name),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  if (locationController.result.distance !=
                                      null)
                                    Container(
                                      height: 50,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1A1A1A),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.map_outlined,
                                                color: Color(0xFF009963),
                                              ),
                                              Text(
                                                "${locationController.result.distance}",
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time_outlined,
                                                color: Color(0xFF009963),
                                              ),
                                              Text(
                                                " ${locationController.result.duration}",
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Set Yout Date & Time:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      DateTime? datePicked =
                                          await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(2024),
                                              lastDate: DateTime(2026),
                                              initialDate: DateTime.now());
                                      if (datePicked != null) {
                                        ridesModel.date = datePicked;
                                        setState(() {});
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          " ${DateFormat('EEEE, MMM d').format(ridesModel.date)}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const Icon(Icons.calendar_month,
                                            color: Color(0xFF009963)),
                                      ],
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                      if (pickedTime != null) {
                                        ridesModel.date = DateTime(
                                            ridesModel.date.year,
                                            ridesModel.date.month,
                                            ridesModel.date.day,
                                            pickedTime.hour,
                                            pickedTime.minute);
                                        setState(() {});
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${DateFormat.jm().format(ridesModel.date)}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Icon(Icons.access_time_outlined,
                                            color: Color(0xFF009963)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  if (!widget.isBooking) ...[
                                    const Text(
                                      "Set the price of ride:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: priceTextController,
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF009963),
                                              width: 1),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFAFA8A8),
                                              width: 1),
                                        ),
                                        hintText: "Your Price",
                                        prefixIcon: Icon(Icons.currency_rupee),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "Description:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      controller: descriptionTextController,
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF009963),
                                              width: 1),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFAFA8A8),
                                              width: 1),
                                        ),
                                        hintText: "Description",
                                        prefixIcon: Icon(Icons.note),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                  const Text(
                                    "Seats:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        7,
                                        (index) => Expanded(
                                              child: ChoiceChip(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  showCheckmark: false,
                                                  onSelected: (value) =>
                                                      setState(() {
                                                        ridesModel.seat =
                                                            index + 1;
                                                      }),
                                                  label: Text("${index + 1}"),
                                                  selected: ridesModel.seat ==
                                                      index + 1),
                                            )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      ridesModel.description =
                                          descriptionTextController.text;
                                      ridesModel.price = double.parse(
                                          priceTextController.text.isEmpty
                                              ? "00.00"
                                              : priceTextController.text);
                                      ridesModel.location =
                                          locationTextController.text;
                                      ridesModel.destination =
                                          destinationTextController.text;
                                      ridesModel.duration =
                                          locationController.result.duration ??
                                              "";
                                      ridesModel.distance =
                                          locationController.result.distance ??
                                              "";
                                      ridesModel.id =
                                          userRepo.userModel!.phoneNo;
                                      ridesModel.riderName =
                                          userRepo.userModel!.fullName;
                                      setState(() {});
                                      await ridesRepo.createRide(ridesModel);
                                      widget.isBooking
                                          ? const SizedBox()
                                          : showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    "Account details"),
                                                content: const Text(
                                                    "Please set your account details"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const BillingDetails(),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                      "Go",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF009963),
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const RidesScreen(),
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      widget.isBooking
                                          ? "Book the ride"
                                          : "Share the ride",
                                      style: const TextStyle(fontSize: 23),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Positioned(top: 10, left: 10, child: BackButton())
              ],
            ),
          ),
        );
      });
    });
  }
}
