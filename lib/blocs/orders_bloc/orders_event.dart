part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class SyncOrdersWithFirebaseEvent extends OrdersEvent {
  const SyncOrdersWithFirebaseEvent();
}

class AddOrdersEvent extends OrdersEvent {
  const AddOrdersEvent({
    required this.orderModels,
  });

  final List<OrderModel> orderModels;
}

class UpdateOrderEvent extends OrdersEvent {
  const UpdateOrderEvent({
    required this.orderModel,
  });

  final OrderModel orderModel;
}

class DeleteOrderEvent extends OrdersEvent {
  const DeleteOrderEvent({
    required this.orderID,
  });

  final String orderID;
}
