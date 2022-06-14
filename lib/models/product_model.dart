import 'package:equatable/equatable.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:usainua/utils/constants.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.deliveryDate,
    required this.deliveryMethod,
    required this.price,
    required this.weight,
    required this.deliveryStatus,
  });

  final String id;
  final DateTime deliveryDate;
  final DeliveryMethod deliveryMethod;
  final double price;
  final double weight;
  final DeliveryStatus deliveryStatus;

  ProductModel copyWith({
    String? id,
    DateTime? deliveryDate,
    DeliveryMethod? deliveryMethod,
    double? price,
    double? weight,
    DeliveryStatus? deliveryStatus,
  }) {
    return ProductModel(
      id: id ?? this.id,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
    );
  }

  Map<String, dynamic> toJson() {
    //TODO
    return {
      'id': id,
      'deliveryDate': deliveryDate,
      'deliveryMethod': enumToString(deliveryMethod),
      'price': price,
      'weight': weight,
      'deliveryStatus': enumToString(deliveryStatus),
    };
  }

  //TODO
  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   return ProductModel(
  //     id: json['id'],
  //     name: json['name'],
  //     email: json['email'],
  //     phoneNumber: json['phoneNumber'],
  //     genderType: enumFromString(
  //       GenderType.values,
  //       json['genderType'],
  //     ),
  //     birthday: json['birthday'] != null ? json['birthday'].toDate() : null,
  //   );
  // }

  @override
  List<Object?> get props => [
        id,
        deliveryDate,
        deliveryMethod,
        price,
        weight,
        deliveryStatus,
      ];
}
