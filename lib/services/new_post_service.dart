import 'package:dio/dio.dart';
import 'package:usainua/models/new_post_models/city_model.dart';
import 'package:usainua/models/new_post_models/region_model.dart';
import 'package:usainua/models/new_post_models/street_model.dart';
import 'package:usainua/models/new_post_models/warehouse_model.dart';

class NewPostService {
  NewPostService._();
  static NewPostService instance = NewPostService._();

  final String _apiKey = '89acf74c605a31f08c4a647b2b869436';

  final Dio _dio = Dio();

  Future<List<RegionModel>> getRegions() async {
    List<RegionModel> regionModels = [];
    Response response = await _dio.post(
      'https://api.novaposhta.ua/v2.0/json/',
      data: {
        'apiKey': _apiKey,
        'modelName': 'Address',
        'calledMethod': 'getAreas',
        'methodProperties': {}
      },
    );
    Map<String, dynamic> data = response.data;

    if (data['success'] == true) {
      List? dataList = data['data'];

      dataList?.forEach((element) {
        regionModels.add(
          RegionModel(
            ref: element['Ref']!,
            regionName: element['DescriptionRu']!,
          ),
        );
      });
    }

    return (regionModels);
  }

  Future<List<CityModel>> getCities({
    required String cityName,
    required String regionRef,
  }) async {
    List<CityModel> cityModels = [];
    Response response = await _dio.post(
      'https://api.novaposhta.ua/v2.0/json/',
      data: {
        'apiKey': _apiKey,
        'modelName': 'Address',
        'calledMethod': 'getCities',
        'methodProperties': {
          'FindByString': cityName,
          'AreaRef': regionRef,
        }
      },
    );

    Map<String, dynamic> data = response.data;

    if (data['success'] == true) {
      List? dataList = data['data'];

      dataList?.forEach(
        (element) {
          cityModels.add(
            CityModel(
              cityName: element['Description']!,
              cityRef: element['Ref']!,
              settlementTypeDescription: element['SettlementTypeDescription']!,
            ),
          );
        },
      );
    }

    return (cityModels);
  }

  Future<List<StreetModel>> getStreets({
    required String streetName,
    required String cityRef,
  }) async {
    List<StreetModel> streetModels = [];
    Response response = await _dio.post(
      'https://api.novaposhta.ua/v2.0/json/',
      data: {
        'apiKey': _apiKey,
        'modelName': 'Address',
        'calledMethod': 'getStreet',
        'methodProperties': {
          'FindByString': streetName,
          'CityRef': cityRef,
        }
      },
    );

    Map<String, dynamic> initData = response.data;

    if (initData['success'] == true) {
      List? dataList = initData['data'];

      dataList?.forEach(
        (element) {
          streetModels.add(
            StreetModel(
              streetName: element['Description']!,
              streetRef: element['Ref']!,
              streetType: element['StreetsType']!,
            ),
          );
        },
      );
    }

    return (streetModels);
  }

  Future<List<WarehouseModel>> getWarehouses({
    required String cityRef,
  }) async {
    List<WarehouseModel> warehouseModels = [];

    Response response = await _dio.post(
      'https://api.novaposhta.ua/v2.0/json/',
      data: {
        'apiKey': _apiKey,
        'modelName': 'Address',
        'calledMethod': 'getWarehouses',
        'methodProperties': {
          'CityRef': cityRef,
        }
      },
    );

    Map<String, dynamic> data = response.data;

    if (data['success'] == true) {
      List? dataList = data['data'];

      dataList?.forEach(
        (element) {
          warehouseModels.add(
            WarehouseModel(
              warehouseName: element['Description']!,
              warehousesRef: element['Ref']!,
            ),
          );
        },
      );
    }
    warehouseModels;
    return (warehouseModels);
  }
}
