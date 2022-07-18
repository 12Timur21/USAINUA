import 'package:equatable/equatable.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:usainua/utils/constants.dart';

class OrderModel extends Equatable {
  const OrderModel({
    required this.id,
    this.link,
    required this.dispatchType,
    this.count,
    this.deliveryDate,
    this.deliveryMethod,
    this.price,
    this.weight,
    required this.deliveryStatus,
    this.additionalServices,
    this.description,
    this.invoiceID,
    this.treckList,
  });

  final String id;
  final String? link;
  final String? description;
  final String? count;
  final DateTime? deliveryDate;
  final DeliveryMethod? deliveryMethod;
  final DispatchType dispatchType;
  final double? price;
  final double? weight;
  final DeliveryStatus? deliveryStatus;
  final List<String>? additionalServices;

  final String? invoiceID;
  final List<String>? treckList;

  OrderModel copyWith({
    String? id,
    String? link,
    String? count,
    String? description,
    DateTime? deliveryDate,
    DeliveryMethod? deliveryMethod,
    DispatchType? dispatchType,
    double? price,
    double? weight,
    DeliveryStatus? deliveryStatus,
    List<String>? additionalServices,
    List<String>? treckList,
    String? invoiceID,
  }) {
    return OrderModel(
      id: id ?? this.id,
      link: link ?? this.link,
      count: count ?? this.count,
      description: description ?? this.description,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      dispatchType: dispatchType ?? this.dispatchType,
      price: price ?? this.price,
      weight: weight ?? this.weight,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      additionalServices: additionalServices ?? this.additionalServices,
      treckList: treckList ?? this.treckList,
      invoiceID: invoiceID ?? this.invoiceID,
    );
  }

  //! Осмотреть
  Map<String, dynamic> toJson() {
    if (dispatchType == DispatchType.purchaseAndDelivery) {
      return {
        'id': id,
        'link': link,
        'description': description,
        'count': count,
        'deliveryDate': deliveryDate?.millisecondsSinceEpoch,
        'deliveryMethod': deliveryMethod?.name,
        'dispatchType': dispatchType.name,
        'additionalServices': additionalServices,
        'price': price,
        'weight': weight,
        'deliveryStatus': enumToString(deliveryStatus),
      };
    }
    return {
      'id': id,
      'invoiceID': invoiceID,
      'treckList': treckList,
      'description': description,
      'deliveryDate': deliveryDate?.millisecondsSinceEpoch,
      'deliveryMethod': deliveryMethod?.name,
      'dispatchType': dispatchType.name,
      'additionalServices': additionalServices,
      'price': price,
      'weight': weight,
      'deliveryStatus': enumToString(deliveryStatus),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      link: json['link'],
      count: json['count'],
      description: json['description'],
      deliveryDate: DateTime.fromMillisecondsSinceEpoch(json['deliveryDate']),
      deliveryMethod: DeliveryMethod.values.byName(json['deliveryMethod']),
      dispatchType: DispatchType.values.byName(json['dispatchType']),
      price: json['price'],
      weight: json['weight'],
      deliveryStatus: DeliveryStatus.values.byName(json['deliveryStatus']),
      additionalServices: json['additionalServices'],
      invoiceID: json['invoiceID'],
      treckList: json['treckList'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        link,
        count,
        description,
        deliveryDate,
        deliveryMethod,
        dispatchType,
        price,
        weight,
        deliveryStatus,
        additionalServices,
        invoiceID,
        treckList,
      ];
}
