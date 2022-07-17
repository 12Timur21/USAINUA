import 'package:flutter/foundation.dart';
import 'package:usainua/models/new_post_models/city_model.dart';
import 'package:usainua/models/new_post_models/region_model.dart';
import 'package:usainua/models/new_post_models/street_model.dart';
import 'package:usainua/models/new_post_models/warehouse_model.dart';
import 'package:usainua/pages/main_pages/account_pages/recipient_addresses_page/recipient_addresses_page.dart';

class RecipentAddressModel {
  const RecipentAddressModel({
    required this.id,
    required this.addressName,
    required this.deliveryType,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.regionModel,
    required this.cityModel,
    this.warehouseModel,
    this.streetModel,
    this.houseNumber,
    this.apartmentNumber,
  });

  final String id;
  final String addressName;
  final DeliveryType deliveryType;
  final String name;
  final String surname;
  final String phoneNumber;
  final RegionModel regionModel;
  final CityModel cityModel;

  final WarehouseModel? warehouseModel;

  final StreetModel? streetModel;
  final String? houseNumber;
  final String? apartmentNumber;

  RecipentAddressModel copyWith({
    String? addressName,
    DeliveryType? deliveryType,
    String? name,
    String? surname,
    String? phoneNumber,
    RegionModel? regionModel,
    CityModel? cityModel,
    WarehouseModel? warehouseModel,
    StreetModel? streetModel,
    String? houseNumber,
    String? apartmentNumber,
  }) {
    return RecipentAddressModel(
      id: id,
      addressName: addressName ?? this.addressName,
      deliveryType: deliveryType ?? this.deliveryType,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      regionModel: regionModel ?? this.regionModel,
      cityModel: cityModel ?? this.cityModel,
      warehouseModel: warehouseModel ?? this.warehouseModel,
      streetModel: streetModel ?? this.streetModel,
      houseNumber: houseNumber ?? this.houseNumber,
      apartmentNumber: apartmentNumber ?? this.apartmentNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addressName': addressName,
      'deliveryType': describeEnum(deliveryType),
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'regionModel': regionModel.toJson(),
      'cityModel': cityModel.toJson(),
      'warehouseModel': warehouseModel?.toJson(),
      'streetModel': streetModel?.toJson(),
      'houseNumber': houseNumber,
      'apartmentNumber': apartmentNumber,
    };
  }

  factory RecipentAddressModel.fromJson(Map<String, dynamic> json) {
    return RecipentAddressModel(
      id: json['id'],
      addressName: json['addressName'],
      deliveryType: DeliveryType.values.byName(json['deliveryType']),
      name: json['name'],
      surname: json['surname'],
      phoneNumber: json['phoneNumber'],
      regionModel: RegionModel.fromJson(json['regionModel']),
      cityModel: CityModel.fromJson(json['cityModel']),
      warehouseModel: json['warehouseModel'] != null
          ? WarehouseModel.fromJson(json['warehouseModel'])
          : null,
      streetModel: json['streetModel'] != null
          ? StreetModel.fromJson(json['streetModel'])
          : null,
      houseNumber: json['houseNumber'],
      apartmentNumber: json['apartmentNumber'],
    );
  }
}
