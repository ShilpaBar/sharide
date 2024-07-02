import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_logger/pretty_logger.dart';
import 'package:sharide/models/directions_model.dart';

class DirectionsRepository {
  String _baseUrl = "https://maps.googleapis.com/maps/api/directions/json?";
  final Dio _dio;
  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();
  Future<DirectionsModel?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final Response response = await _dio.get(
      _baseUrl,
      queryParameters: {
        "origin": "${origin.latitude},${origin.longitude}",
        "destination": "${destination.latitude},${destination.longitude}",
        "key": "AIzaSyCXv65AyQIMLKpEV0FJV-N-xj6l-IdUAuE",
      },
    );
    if (response.statusCode == 200) {
      PLog.cyan(jsonEncode(response.data));
      return DirectionsModel.fromMap(response.data);
    }
    return null;
  }
}
