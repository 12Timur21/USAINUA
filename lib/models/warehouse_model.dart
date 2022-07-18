class WarehouseModel {
  const WarehouseModel({
    required this.warehouseName,
    required this.fullName,
    required this.street,
    required this.city,
    required this.state,
    required this.index,
    required this.phoneNumber,
  });
  final String warehouseName;
  final String fullName;
  final String street;
  final String city;
  final String state;
  final String index;
  final String phoneNumber;

  Map<String, dynamic> toJson() {
    return {
      'warehouseName': warehouseName,
      'fullName': fullName,
      'street': street,
      'city': city,
      'state': state,
      'index': index,
      'phoneNumber': phoneNumber,
    };
  }

  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
      warehouseName: json['warehouseName'],
      fullName: json['fullName'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      index: json['index'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
