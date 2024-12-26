import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Helper functions for Cap serialization
Cap capFromString(String cap) {
  switch (cap) {
    case 'buttCap':
      return Cap.buttCap;
    case 'roundCap':
      return Cap.roundCap;
    case 'squareCap':
      return Cap.squareCap;
    default:
      return Cap.buttCap;
  }
}

String capToString(Cap cap) {
  if (cap == Cap.roundCap) {
    return 'roundCap';
  } else if (cap == Cap.squareCap) {
    return 'squareCap';
  } else {
    return 'buttCap';
  }
}

// Extensions for LatLng serialization
extension LatLngExtension on LatLng {
  static LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(
      json['latitude'] as double,
      json['longitude'] as double,
    );
  }

  static Map<String, dynamic> toJson(LatLng instance) => {
        'latitude': instance.latitude,
        'longitude': instance.longitude,
      };
}

// Extensions for PatternItem serialization
extension PatternItemExtension on PatternItem {
  static PatternItem fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'dot':
        return PatternItem.dot;
      case 'gap':
        return PatternItem.gap(json['length']);
      case 'dash':
        return PatternItem.dash(json['length']);
      default:
        throw Exception('Unknown PatternItem type');
    }
  }
}

// Extensions for Polyline serialization
extension PolylineExtension on Polyline {
  static Polyline fromJson(Map<String, dynamic> json) {
    return Polyline(
      polylineId: PolylineId(json['polylineId'] as String),
      consumeTapEvents: json['consumeTapEvents'] as bool? ?? false,
      color: Color(json['color'] as int? ?? Colors.black.value),
      endCap: capFromString(json['endCap'] as String? ?? 'buttCap'),
      geodesic: json['geodesic'] as bool? ?? false,
      jointType: JointType.mitered, // Assuming default value as mitered
      points: (jsonDecode(json['points']) as List)
          .map((e) => LatLngExtension.fromJson(e as Map<String, dynamic>))
          .toList(),
      patterns: (jsonDecode(json['patterns']) as List)
          .map((e) => PatternItemExtension.fromJson(e as Map<String, dynamic>))
          .toList(),
      startCap: capFromString(json['startCap'] as String? ?? 'buttCap'),
      visible: json['visible'] as bool? ?? true,
      width: json['width'] as int? ?? 10,
      zIndex: json['zIndex'] as int? ?? 0,
      onTap: null, // Note: onTap cannot be serialized
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'polylineId': polylineId.value,
      'consumeTapEvents': consumeTapEvents,
      'color': color.value,
      'endCap': capToString(endCap),
      'geodesic': geodesic,
      'points':
          jsonEncode(points.map((e) => LatLngExtension.toJson(e)).toList()),
      'patterns': jsonEncode(patterns.map((e) => e.toJson()).toList()),
      'startCap': capToString(startCap),
      'visible': visible,
      'width': width,
      'zIndex': zIndex,
    };
  }
}

// RidesModel class with serialization methods
class RidesModel {
  String? id;
  String? riderName;
  String? location;
  LatLng? locationCoordinats;
  Polyline? polyLines;
  String? destination;
  LatLng? destinationCoordinats;
  List<LatLng> points;
  DateTime date;
  double? price;
  int? seat;
  String? transportType;
  String? description;
  String? duration;
  String? distance;

  RidesModel({
    this.id,
    this.riderName,
    this.location,
    this.destination,
    DateTime? date,
    this.points = const [],
    this.price,
    this.seat = 1,
    this.transportType = "Sedan",
    this.description,
    this.duration,
    this.distance,
    this.polyLines,
    this.destinationCoordinats,
    this.locationCoordinats,
  }) : date = date ?? DateTime.now();

  RidesModel copywith({
    String? id,
    String? riderName,
    DateTime? date,
    double? price,
    String? location,
    LatLng? locationCoordinats,
    String? destination,
    LatLng? destinationCoordinats,
    List<LatLng>? points,
    Polyline? polyLines,
    int? seat,
    String? transportType,
    String? description,
    String? duration,
    String? distance,
  }) {
    return RidesModel(
      id: id ?? this.id,
      riderName: riderName ?? this.riderName,
      date: date ?? this.date,
      location: location ?? this.location,
      destination: destination ?? this.destination,
      destinationCoordinats:
          destinationCoordinats ?? this.destinationCoordinats,
      locationCoordinats: locationCoordinats ?? this.locationCoordinats,
      points: points ?? this.points,
      polyLines: polyLines ?? this.polyLines,
      price: price ?? this.price,
      seat: seat ?? this.seat,
      transportType: transportType ?? this.transportType,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rideName': riderName,
      'location': location,
      'location_coordinats': locationCoordinats?.toJson(),
      'destination_coordinats': destinationCoordinats?.toJson(),
      'polypoints': points.map((e) => LatLngExtension.toJson(e)).toList(),
      'polylines': jsonEncode(polyLines?.toMap()),
      'destination': destination,
      'date': date.toIso8601String(),
      'price': price.toString(),
      'seat': seat,
      'transport_type': transportType,
      'description': description,
      'duration': duration,
      'distance': distance,
    };
  }

  factory RidesModel.fromMap(Map<String, dynamic> map) {
    return RidesModel(
      id: map['id'],
      riderName: map['rideName'],
      location: map['location'],
      locationCoordinats: map['location_coordinats'] == null
          ? null
          : LatLng.fromJson(map['location_coordinats']),
      destinationCoordinats: map['destination_coordinats'] == null
          ? null
          : LatLng.fromJson(map['destination_coordinats']),
      points: map['polypoints'] == null
          ? []
          : List.from((map['polypoints'] as List)
              .map((e) => LatLngExtension.fromJson(e))),
      polyLines: map['polylines'] == null
          ? null
          : PolylineExtension.fromJson(jsonDecode(map['polylines'])),
      destination: map['destination'],
      date: DateTime.parse(map['date']),
      price: double.parse(map['price']),
      transportType: map['transport_type'],
      seat: map['seat'],
      description: map['description'],
      duration: map['duration'],
      distance: map['distance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RidesModel.fromJson(String source) =>
      RidesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RidesModel(id: $id, rideName: $riderName, location: $location, destination: $destination, date: $date, price: $price, seat: $seat, description: $description, transport_type: $transportType, duration: $duration, distance: $distance)';
  }
}
