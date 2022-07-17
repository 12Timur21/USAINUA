class StreetModel {
  const StreetModel({
    required this.streetName,
    required this.streetRef,
    required this.streetType,
  });
  final String streetName;
  final String streetRef;
  final String streetType;

  Map<String, dynamic> toJson() {
    return {
      'streetName': streetName,
      'streetRef': streetRef,
      'streetType': streetType,
    };
  }

  factory StreetModel.fromJson(Map<String, dynamic> json) {
    return StreetModel(
      streetName: json['streetName'],
      streetRef: json['streetRef'],
      streetType: json['streetType'],
    );
  }
}
