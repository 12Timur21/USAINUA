import 'package:google_maps_webservice/places.dart';

class GoogleMapsSerivice {
  GoogleMapsSerivice._();
  static GoogleMapsSerivice instance = GoogleMapsSerivice._();

  final GoogleMapsPlaces _googleMapsPlaces = GoogleMapsPlaces(
    apiKey: 'AIzaSyBdfVMZq9NsE7kEn3B0MzNGfC8ZeZ8TiBM',
    apiHeaders: {
      'Access-Control-Allow-Origin': '*',
    },
  );

  Future<List<Prediction>> getRegions(String regionName) async {
    PlacesAutocompleteResponse response = await _googleMapsPlaces.autocomplete(
      regionName,
      types: [
        '(regions)',
      ],
      components: [
        Component(
          'country',
          'ua',
        ),
      ],
    );
    print(response.status);
    print(response.errorMessage);

    return response.predictions;
  }

  Future<List<Prediction>> getCities(String regionName) async {
    PlacesAutocompleteResponse response = await _googleMapsPlaces.autocomplete(
      regionName,
      types: [
        '(cities)',
      ],
      components: [
        Component(
          'country',
          'ua',
        ),
      ],
    );
    print(response.status);
    print(response.errorMessage);

    return response.predictions;
  }

  Future<List<Prediction>> getStreets(String streetName) async {
    PlacesAutocompleteResponse response = await _googleMapsPlaces.autocomplete(
      streetName,
      types: [
        'address',
      ],
      components: [
        Component(
          'country',
          'ua',
        ),
      ],
    );
    print(response.status);
    print(response.errorMessage);

    return response.predictions;
  }
}
