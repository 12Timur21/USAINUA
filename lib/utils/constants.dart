import 'package:flutter/foundation.dart';

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
  waitingInTheMail,
  successfullyRecived,
  leaveFeedback,
}

extension DeliveryStatusExtension on DeliveryStatus {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case DeliveryStatus.operatorWaiting:
        return 'Ожидание оператора';

      case DeliveryStatus.notPaid:
        return 'Не оплачено';

      case DeliveryStatus.awaitingToSend:
        return 'Ожидает отправки';

      case DeliveryStatus.sentToYou:
        return 'Отправлено вам';

      case DeliveryStatus.waitingInTheMail:
        return 'Ожидает на почте';

      case DeliveryStatus.successfullyRecived:
        return 'Успешно получено';

      case DeliveryStatus.leaveFeedback:
        return 'Ожидает отзыва';

      default:
        throw Exception('Enum does not has this name');
    }
  }
}

enum AdditionalServices {
  orderPhoto,
  additionalPackaging,
  inclusionCheck,
}

extension AdditionalServiceExtension on AdditionalServices {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case AdditionalServices.orderPhoto:
        return 'Фото товара';
      case AdditionalServices.additionalPackaging:
        return 'Дополнительная упаковка';
      case AdditionalServices.inclusionCheck:
        return 'Проверить устройство';

      default:
        throw Exception('Enum does not has this name');
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

extension WebsiteSectionsExtension on WebsiteSections {
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

enum GenderType {
  man,
  woman,
}

extension GenderTypextension on GenderType {
  String get name => describeEnum(this);
  String? get displayTitle {
    switch (this) {
      case GenderType.man:
        return 'Мужчина';
      case GenderType.woman:
        return 'Женщина';

      default:
        return null;
    }
  }

  GenderType? enumFromString(String? value) {
    switch (value) {
      case 'Мужчина':
        return GenderType.man;
      case 'Женщина':
        return GenderType.woman;

      default:
        return null;
    }
  }
}
