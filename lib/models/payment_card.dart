import 'package:equatable/equatable.dart';

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

class PaymentCard extends Equatable {
  final PaymentCardType type;
  final int number;
  final int month;
  final int year;
  final int cvv;

  const PaymentCard({
    required this.type,
    required this.number,
    required this.month,
    required this.year,
    required this.cvv,
  });

  @override
  List<Object?> get props => [
        type,
        number,
        month,
        year,
        cvv,
      ];
}
