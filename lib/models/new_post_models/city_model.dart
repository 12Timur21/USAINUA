class CityModel {
  const CityModel({
    required this.cityName,
    required this.cityRef,
    required this.settlementTypeDescription,
  });
  final String cityName;
  final String cityRef;
  final String settlementTypeDescription;

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'cityRef': cityRef,
      'settlementTypeDescription': settlementTypeDescription,
    };
  }

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityName: json['cityName'],
      cityRef: json['cityRef'],
      settlementTypeDescription: json['settlementTypeDescription'],
    );
  }
}
