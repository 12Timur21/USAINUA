import 'package:equatable/equatable.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:usainua/utils/constants.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.link,
    this.count,
    this.deliveryDate,
    this.deliveryMethod,
    this.price,
    this.weight,
    required this.deliveryStatus,
    this.additionalServices,
    this.description,
  });

  final String id;
  final String link;
  final String? description;
  final String? count;
  final DateTime? deliveryDate;
  final DeliveryMethod? deliveryMethod;
  final double? price;
  final double? weight;
  final DeliveryStatus? deliveryStatus;
  final String? additionalServices;

  ProductModel copyWith({
    String? id,
    String? link,
    String? count,
    String? description,
    DateTime? deliveryDate,
    DeliveryMethod? deliveryMethod,
    double? price,
    double? weight,
    DeliveryStatus? deliveryStatus,
    String? additionalServices,
  }) {
    return ProductModel(
      id: id ?? this.id,
      link: link ?? this.link,
      count: count ?? this.count,
      description: description ?? this.description,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      additionalServices: additionalServices ?? this.additionalServices,
    );
  }

  Map<String, dynamic> toJson() {
    //TODO
    return {
      'id': id,
      'link': link,
      'description': description,
      'count': count,
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
        link,
        description,
        count,
        deliveryDate,
        deliveryMethod,
        price,
        weight,
        deliveryStatus,
      ];
}
