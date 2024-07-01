import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DirectionsModel {
  LatLngBounds bounds;
  List<PointLatLng> polylinePoints;
  String totalDistance;
  String totalDuration;

  DirectionsModel({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });
  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) throw Exception("No routes found.");

    final data = Map<String, dynamic>.from(map['routes'][0]);
    final northeast = data["bounds"]["northeast"];
    final southWest = data["bounds"]["southwest"];
    final bounds = LatLngBounds(
      southwest: LatLng(southWest["lat"], southWest["lng"]),
      northeast: LatLng(northeast["lat"], northeast["lng"]),
    );

    String distance = "";
    String duration = "";
    if ((data["legs"] as List).isNotEmpty) {
      final leg = data["legs"][0];
      distance = leg["distance"]["text"];
      duration = leg["duration"]["text"];
    }
    return DirectionsModel(
      bounds: bounds,
      polylinePoints: PolylinePoints().decodePolyline(data["overview_polyline"]
          ["points"]), // Initialize with appropriate data
      totalDistance: distance, // Initialize with appropriate data
      totalDuration: duration, // Initialize with appropriate data
    );
  }
}
