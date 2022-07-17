class RegionModel {
  const RegionModel({
    required this.ref,
    required this.regionName,
  });

  final String ref;
  final String regionName;

  Map<String, dynamic> toJson() {
    return {
      'ref': ref,
      'regionName': regionName,
    };
  }

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      ref: json['ref'],
      regionName: json['regionName'],
    );
  }
}
