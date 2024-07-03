// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class RidesModel {
  String? id;
  String? riderName;
  String? location;
  String? destination;
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
    this.price,
    this.seat = 1,
    this.transportType = "Sedan",
    this.description,
    this.duration,
    this.distance,
  }) : date = date ?? DateTime.now();

  RidesModel copywith({
    String? id,
    String? riderName,
    DateTime? date,
    double? price,
    String? location,
    String? destination,
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
    return 'RidesModel(id: $id, rideName: $riderName,location:$location,destination:$destination, date: $date, price: $price, seat: $seat, description: $description, transport_type:$transportType, duration:$duration, distance:$distance)';
  }
}
