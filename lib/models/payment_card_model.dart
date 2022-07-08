import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:usainua/utils/constants.dart';

class PaymentCardModel extends Equatable {
  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      id: json['id'],
      type: PaymentCardType.values.byName(json['type']),
      number: json['number'],
      month: json['month'],
      year: json['year'],
      cvv: json['cvv'],
    );
  }
  const PaymentCardModel({
    this.type,
    required this.id,
    required this.number,
    required this.month,
    required this.year,
    required this.cvv,
  });
  final String? id;
  final PaymentCardType? type;
  final int number;
  final int month;
  final int year;
  final int cvv;

  PaymentCardModel copyWith({
    String? id,
    PaymentCardType? type,
    int? number,
    int? month,
    int? year,
    int? cvv,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      type: type ?? this.type,
      number: number ?? this.number,
      month: month ?? this.month,
      year: year ?? this.year,
      cvv: cvv ?? this.cvv,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type != null ? describeEnum(type!) : null,
      'number': number,
      'month': month,
      'year': year,
      'cvv': cvv,
    };
  }

  @override
  List<Object?> get props => [
        id,
        type,
        number,
        month,
        year,
        cvv,
      ];
}
