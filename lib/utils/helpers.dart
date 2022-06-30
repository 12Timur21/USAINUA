import 'package:usainua/utils/constants.dart';

int? getIntFromString(String? string) {
  if (string == null) return null;

  return double.tryParse(
    string.replaceAll(
      RegExp(r'[^0-9\.]'),
      '',
    ),
  )?.toInt();
}

double? calculatePrice({
  required double price,
  required DeliveryMethod deliveryMethod,
  required String additionalServices,
  required double weight,
  required int count,
}) {
  return price * count;
}
