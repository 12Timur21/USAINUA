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
  operatorWaiting,
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

extension SelectedAdditionalServiceExtension on AdditionalServices {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case AdditionalServices.productPhoto:
        return 'Фото товара';
      case AdditionalServices.additionalPackaging:
        return 'Дополнительная упаковка';
      case AdditionalServices.inclusionCheck:
        return 'Проверить устройство';

      default:
        throw Exception('Enum does not has this name');
    }
  }

  AdditionalServices enumFromString(String value) {
    switch (value) {
      case 'Фото товара':
        return AdditionalServices.productPhoto;
      case 'Дополнительная упаковка':
        return AdditionalServices.additionalPackaging;
      case 'Проверить устройство':
        return AdditionalServices.inclusionCheck;

      default:
        throw Exception('Enum does not has this string');
    }
  }
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

extension SelectedWebsiteExtension on WebsiteSections {
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
