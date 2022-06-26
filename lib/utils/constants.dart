import 'package:flutter/foundation.dart';

const double bottomNavBarHeight = 80;

enum DispatchType {
  purchaseAndDelivery,
  deliveryOnly,
}

enum PaymentCardType {
  masterCard,
  visa,
  verve,
  americanExpress,
  discover,
  dinersClub,
  jcb,
  others,
  invalid,
}

enum ShoppingMalls {
  ebay,
  amazon,
  macys,
  wallmart,
}

enum DeliveryMethod {
  air,
  sea,
}

enum DeliveryStatus {
  notPaid,
  awaitingToSend,
  sentToYou,
  successfullyRecived,
  leaveFeedback,
}

enum AdditionalServices {
  productPhoto,
  additionalPackaging,
  inclusionCheck,
}

enum WebCites {
  amazon,
  ebay,
  wallmart,
}

enum WebsiteSections {
  popular,
  shoes,
  clothes,
  electronics,
}

extension SelectedColorExtension on WebsiteSections {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case WebsiteSections.popular:
        return 'Топ товары';
      case WebsiteSections.shoes:
        return 'Обувь';
      case WebsiteSections.clothes:
        return 'Одежда';
      case WebsiteSections.electronics:
        return 'Электрика';
      default:
        throw Exception('Enum does not has name');
    }
  }
}
