import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sharide/location/locationhelper.dart';
import 'package:sharide/models/directions_model.dart';
import 'package:sharide/models/rides_model.dart';
import 'package:sharide/repository/directions_repository.dart';
import 'package:sharide/bottom_nav/home/pages/rides_screen.dart';

class BookRideScreen extends StatefulWidget {
  const BookRideScreen({super.key});

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

class _BookRideScreenState extends State<BookRideScreen> {
  Marker? _origin;
  Marker? _destination;
  DirectionsModel? _info;
  RidesModel ridesModel = RidesModel();
  GoogleMapController? _googleMapController;
  LocationController locationHelper = Get.find<LocationController>();

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId("Origin"),
          infoWindow: InfoWindow(title: "Origin"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null;
        _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: MarkerId("Destination"),
          infoWindow: InfoWindow(title: "Destination"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });
      final directionsModel = await DirectionsRepository()
          .getDirections(origin: _origin!.position, destination: pos);
      setState(() => _info = directionsModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<LocationController>(builder: (_) {
              return locationHelper.myPosition == null
                  ? Center(
                      child:
                          Text(" Please wait while we fetching your location"),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        GoogleMap(
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            zoom: 15,
                            target: LatLng(locationHelper.myPosition!.latitude,
                                locationHelper.myPosition!.longitude),
                          ),
                          markers: {
                            if (_origin != null) _origin!,
                            if (_destination != null) _destination!,
                          },
                          onLongPress: _addMarker,
                          polylines: {
                            if (_info != null)
                              Polyline(
                                polylineId: PolylineId("Overview_polyline"),
                                color: Colors.red,
                                width: 5,
                                points: _info!.polylinePoints
                                    .map((e) => LatLng(e.latitude, e.longitude))
                                    .toList(),
                              ),
                          },
                        ),
                        if (_info != null)
                          Positioned(
                            top: 20,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 6.0,
                                  )
                                ],
                              ),
                              child: Text(
                                "${_info?.totalDistance}, ${_info?.totalDuration}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                      ],
                    );
            }),
            DraggableScrollableSheet(
              expand: true,
              shouldCloseOnMinExtent: true,
              minChildSize: .3,
              initialChildSize: .3,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 25, right: 25, top: 20),
                    height: MediaQuery.sizeOf(context).height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set your location & destination",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "From",
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.near_me,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF009963), width: 2),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFAFA8A8), width: 2),
                                  ),
                                  hintText: "Your Location",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "To",
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFF009963), width: 2),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFAFA8A8), width: 2),
                                  ),
                                  hintText: "Your Destination",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 700,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Color(0xFF2E2E2E),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose Your Transport:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xFF009963),
                                        child: Icon(
                                          Icons.directions_car_filled,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text("Car")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xFF009963),
                                        child: Icon(
                                          Icons.two_wheeler,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text("Bike")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xFF009963),
                                        child: Icon(
                                          Icons.local_taxi,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text("Taxi")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0xFF009963),
                                        child: Image.asset(
                                          "assets/images/Auto.png",
                                          scale: 3.5,
                                        ),
                                      ),
                                      Text("Auto")
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 50,
                                width: 350,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1A1A1A),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.map_outlined,
                                          color: Color(0xFF009963),
                                        ),
                                        Text(
                                          " 8km",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          color: Color(0xFF009963),
                                        ),
                                        Text(
                                          " 45min",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Set Yout Date & Time:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  DateTime? datePicked = await showDatePicker(
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
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(Icons.calendar_month,
                                        color: Color(0xFF009963)),
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  TimeOfDay? timePicked = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());
                                  if (timePicked != null) {
                                    ridesModel.date = DateTime(
                                        ridesModel.date.year,
                                        ridesModel.date.month,
                                        ridesModel.date.day,
                                        timePicked.hour,
                                        timePicked.minute);
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${DateFormat.jm().format(ridesModel.date)}",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(Icons.access_time_outlined,
                                        color: Color(0xFF009963)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Seats:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        minimumSize: Size(70, 50)),
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        minimumSize: Size(70, 50)),
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        minimumSize: Size(70, 50)),
                                    child: Text(
                                      "3",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                        minimumSize: Size(70, 50)),
                                    child: Text(
                                      "4",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RidesScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Continue",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
