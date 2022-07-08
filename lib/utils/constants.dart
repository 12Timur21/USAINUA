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

extension DeliveryMethodExtension on DeliveryMethod {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case DeliveryMethod.air:
        return 'Авиадоставка';
      case DeliveryMethod.sea:
        return 'Бысторое море';

      default:
        throw Exception('Enum does not has this name');
    }
  }

  DeliveryMethod enumFromString(String value) {
    switch (value) {
      case 'Авиадоставка':
        return DeliveryMethod.air;
      case 'Бысторое море':
        return DeliveryMethod.sea;

      default:
        throw Exception('Enum does not has this string');
    }
  }
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

  DeliveryStatus enumFromString(String value) {
    switch (value) {
      case 'Ожидание оператора':
        return DeliveryStatus.operatorWaiting;

      case 'Не оплачено':
        return DeliveryStatus.notPaid;

      case 'Ожидает отправки':
        return DeliveryStatus.awaitingToSend;

      case 'Отправлено вам':
        return DeliveryStatus.sentToYou;

      case 'Ожидает на почте':
        return DeliveryStatus.waitingInTheMail;

      case 'Успешно получено':
        return DeliveryStatus.successfullyRecived;

      case 'Ожидает отзыва':
        return DeliveryStatus.leaveFeedback;

      default:
        throw Exception('Enum does not has this string');
    }
  }
}

enum AdditionalServices {
  productPhoto,
  additionalPackaging,
  inclusionCheck,
}

extension AdditionalServiceExtension on AdditionalServices {
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
