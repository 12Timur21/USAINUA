import 'package:usainua/utils/constants.dart';

class DeliveryStatusModel {
  final DeliveryStatus deliveryStatus;
  final String svgIconUrl;
  final String textStatus;

  const DeliveryStatusModel({
    required this.deliveryStatus,
    required this.svgIconUrl,
    required this.textStatus,
  });
}
