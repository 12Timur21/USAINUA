import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_filling_form_state.dart';

class ProductFillingFormCubit extends Cubit<ProductFillingFormState> {
  ProductFillingFormCubit() : super(const ProductFillingFormState());

  void toogleExtendMode() {
    emit(
      state.copyWith(
        isExtended: !state.isExtended,
      ),
    );
  }

  void changeItemCount(int count) {
    emit(
      state.copyWith(
        itemCount: count,
      ),
    );
  }
}
