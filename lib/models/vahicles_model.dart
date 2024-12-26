class VehiclesModel {
  String name;
  String icon;
  VehiclesModel({
    required this.name,
    required this.icon,
  });

  VehiclesModel copyWith({
    String? name,
    String? icon,
  }) {
    return VehiclesModel(
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }
}
