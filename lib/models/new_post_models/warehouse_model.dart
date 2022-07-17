class WarehouseModel {
  const WarehouseModel({
    required this.warehouseName,
    required this.warehousesRef,
  });
  final String warehouseName;
  final String warehousesRef;

  Map<String, dynamic> toJson() {
    return {
      'warehouseName': warehouseName,
      'warehousesRef': warehousesRef,
    };
  }

  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
      warehouseName: json['warehouseName'],
      warehousesRef: json['warehousesRef'],
    );
  }
}
