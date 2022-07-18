part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  const OrdersState({
    this.orderModels = const [],
  });

  final List<OrderModel> orderModels;

  OrdersState copyWith({
    List<OrderModel>? orderModels,
  }) {
    return OrdersState(
      orderModels: orderModels ?? this.orderModels,
    );
  }

  @override
  List<Object> get props => [
        orderModels,
      ];
}
