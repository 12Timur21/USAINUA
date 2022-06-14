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
