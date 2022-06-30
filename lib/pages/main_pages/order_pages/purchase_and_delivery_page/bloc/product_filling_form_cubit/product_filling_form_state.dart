part of 'product_filling_form_cubit.dart';

class ProductFillingFormState extends Equatable {
  const ProductFillingFormState({
    this.isExtended = false,
    this.itemCount = 1,
  });

  final bool isExtended;
  final int itemCount;

  ProductFillingFormState copyWith({
    bool? isExtended,
    int? itemCount,
  }) {
    return ProductFillingFormState(
      isExtended: isExtended ?? this.isExtended,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  @override
  List<Object> get props => [
        isExtended,
        itemCount,
      ];
}
