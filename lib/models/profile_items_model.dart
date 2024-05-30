import 'package:flutter/material.dart';

class ProfileItemsModel {
  IconData leading;
  String title;
  ProfileItemsModel({
    this.leading = Icons.settings,
    this.title = "Settings",
  });

  ProfileItemsModel copyWith({
    IconData? leading,
    String? title,
  }) {
    return ProfileItemsModel(
      leading: leading ?? this.leading,
      title: title ?? this.title,
    );
  }
}
