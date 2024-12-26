import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as placessdk;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:sharide/constants/app_constants.dart';

class LocationController extends GetxController {
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  placessdk.FlutterGooglePlacesSdk places =
      placessdk.FlutterGooglePlacesSdk(AppConstants.gmapApiKey);
  Position? myPosition;
  Set<Polyline> polyLines = {};
  Marker? origin;
  Marker? destination;
  Future<LocationSettings> getLocationSettings() async {
    if (Platform.isAndroid) {
      return AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 10,
        // forceLocationManager: true,
        // intervalDuration: const Duration(seconds: 1),

        //(Optional) Set foreground notification config to keep the app alive
        //when going to the background
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "Sharide will continue to receive your location even when you aren't using it",
          notificationTitle: "Sharide Running in Background",
          enableWakeLock: true,
        ),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      return AppleSettings(
        accuracy: LocationAccuracy.best,
        activityType: ActivityType.automotiveNavigation,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: true,
      );
    } else {
      return LocationSettings(accuracy: LocationAccuracy.bestForNavigation);
    }
  }

  getMyPosition() async {
    if (await geolocatorPlatform.requestPermission() ==
            LocationPermission.always ||
        await geolocatorPlatform.requestPermission() ==
            LocationPermission.whileInUse) {
      myPosition = await geolocatorPlatform.getCurrentPosition(
          locationSettings: await getLocationSettings());
      PLog.green("$myPosition");
      update();
    }
  }

  Future<String>? getAddressFromPosition(LatLng pos) async {
    final placemarkList =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark placeMark = placemarkList.first;
    PLog.red(
        "${placeMark.street},${placeMark.subThoroughfare},${placeMark.thoroughfare},${placeMark.subLocality},${placeMark.locality},${placeMark.administrativeArea},${placeMark.postalCode}");
    return "${placeMark.street},${placeMark.subThoroughfare},${placeMark.thoroughfare},${placeMark.subLocality},${placeMark.locality},${placeMark.administrativeArea},${placeMark.postalCode}";
  }

  Future<LatLng?> getLocationFromAddress(String option) async {
    List<Location> locations = await locationFromAddress(option);

    if (locations.isNotEmpty) {
      return LatLng(locations.first.latitude, locations.first.longitude);
    } else {
      return null;
    }
  }

  Future<List<String>> getAddressPrediction(String searchValue) async {
    placessdk.FindAutocompletePredictionsResponse? predictionsResponse =
        await places.findAutocompletePredictions(searchValue);

    return predictionsResponse.predictions.map((p) => p.fullText).toList();
  }

  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    update();
  }

  void addMarker(LatLng pos) async {
    if (origin == null || (origin != null && destination != null)) {
      origin = Marker(
        markerId: const MarkerId("Origin"),
        infoWindow: const InfoWindow(title: "Origin"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      destination = null;
      update();
    } else {
      destination = Marker(
        markerId: const MarkerId("Destination"),
        infoWindow: const InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
      update();
      // final directionsModel = await DirectionsRepository()
      //     .getDirections(origin: _origin!.position, destination: pos);
      await getRoute();
      // setState(() => _info = directionsModel);
    }
  }

  void setOrigin(String address) async {
    LatLng? pos = await getLocationFromAddress(address);
    if (pos != null) {
      origin = Marker(
        markerId: const MarkerId("Origin"),
        infoWindow: const InfoWindow(title: "Origin"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      update();
    }
  }

  void setDestination(String address) async {
    LatLng? pos = await getLocationFromAddress(address);

    if (pos != null) {
      destination = Marker(
        markerId: const MarkerId("Destination"),
        infoWindow: const InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
      update();
    }
    if (origin != null && destination != null) {
      await getRoute();
    }
  }

  PolylineResult result = PolylineResult();
  getRoute({TravelMode travelMode = TravelMode.driving}) async {
    PolylinePoints polylinePoints = PolylinePoints();
    result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
          origin: PointLatLng(
              origin!.position.latitude, origin!.position.longitude),
          destination: PointLatLng(
              destination!.position.latitude, destination!.position.longitude),
          mode: travelMode),
      googleApiKey: AppConstants.gmapApiKey,
    );
    update();

    if (result.points.isNotEmpty) {
      // PLog.green("${result.points.map((e) => e.longitude)}");

      PLog.green("${result.points.map((e) => e.longitude).toList()}");
      PLog.cyan("${result.points.map((e) => e.longitude).toList()}");

      polyLines = {
        Polyline(
          polylineId: const PolylineId("Overview_polyline"),
          color: Colors.redAccent,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          points: result.points
              .map(
                (point) => LatLng(point.latitude, point.longitude),
              )
              .toList(),
        ),
      };

      update();
      await focusOnPolyline();
    }
  }

  focusOnPolyline() async {
    // final GoogleMapController controller = await mapController.future;
    LatLngBounds bounds;
    if (origin!.position.latitude > destination!.position.latitude &&
        origin!.position.longitude > destination!.position.longitude) {
      bounds = LatLngBounds(
          southwest: destination!.position, northeast: origin!.position);
    } else {
      bounds = LatLngBounds(
          southwest: origin!.position, northeast: destination!.position);
    }
    update();
    (await mapController.future)
        .animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    update();
  }
}
