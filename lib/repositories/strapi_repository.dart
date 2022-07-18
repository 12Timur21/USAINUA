import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:usainua/models/warehouse_model.dart';

class StrapiRepository {
  static const String _strapi = 'https://obscure-bayou-25917.herokuapp.com/api';

  Future<List<WarehouseModel>> getWarehouses() async {
    final List<WarehouseModel> warehouseModels = [];

    try {
      final response = await Dio().get<Map<String, dynamic>?>(
        '$_strapi/Warehouses',
      );

      List warehousesJsonList = response.data?['data'];
      for (Map<String, dynamic> json in warehousesJsonList) {
        warehouseModels.add(
          WarehouseModel.fromJson(json['attributes']),
        );
      }
    } catch (e) {
      log('strapi error: $e');
      throw Exception(e);
    }

    return warehouseModels;
  }
}
