import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:usainua/utils/constants.dart';

class PaymentCardModel extends Equatable {
  final PaymentCardType type;
  final int number;
  final int month;
  final int year;
  final int cvv;

  const PaymentCardModel({
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
