import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usainua/models/order_model.dart';
import 'package:usainua/repositories/firestore_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(const OrdersState()) {
    on<SyncOrdersWithFirebaseEvent>((event, emit) async {
      List<OrderModel> orderModels =
          await FirestoreRepository.instance.getAllOrders();

      emit(
        OrdersState(
          orderModels: orderModels,
        ),
      );
    });

    on<AddOrdersEvent>((event, emit) {
      List<OrderModel> orderModels = [...state.orderModels];

      FirestoreRepository.instance.createOrder(
        orderModels: event.orderModels,
      );

      orderModels.addAll(event.orderModels);

      emit(
        state.copyWith(
          orderModels: event.orderModels,
        ),
      );
    });

    // on<UpdateOrderEvent>((event, emit) {
    //   FirestoreRepository.instance.updateSelectedRecipientAddressModel(
    //     recipentAddressID: event.recipentAddressID,
    //   );

    //   emit(
    //     state.copyWith(
    //       selectedRecipentAddressID: event.recipentAddressID,
    //     ),
    //   );
    // });

    on<DeleteOrderEvent>((event, emit) {
      List<OrderModel> orderModels = [...state.orderModels];

      FirestoreRepository.instance.deleteOrder(
        orderID: event.orderID,
      );

      orderModels.removeWhere(
        (element) => element.id == event.orderID,
      );

      emit(
        state.copyWith(
          orderModels: orderModels,
        ),
      );
    });
  }
}
