class NewPostWarehouseModel {
  const NewPostWarehouseModel({
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

  factory NewPostWarehouseModel.fromJson(Map<String, dynamic> json) {
    return NewPostWarehouseModel(
      warehouseName: json['warehouseName'],
      warehousesRef: json['warehousesRef'],
    );
  }
}
