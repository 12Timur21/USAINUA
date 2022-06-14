import 'package:usainua/utils/constants.dart';

class DeliveryStatusModel {
  const DeliveryStatusModel({
    required this.deliveryStatus,
    required this.svgIconUrl,
    required this.textStatus,
  });
  final DeliveryStatus deliveryStatus;
  final String svgIconUrl;
  final String textStatus;
}
