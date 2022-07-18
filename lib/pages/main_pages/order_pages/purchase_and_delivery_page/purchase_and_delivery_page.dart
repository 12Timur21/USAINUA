import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:usainua/blocs/orders_bloc/orders_bloc.dart';
import 'package:usainua/models/order_model.dart';
import 'package:usainua/pages/main_pages/order_pages/purchase_and_delivery_page/bloc/product_filling_form_cubit/product_filling_form_cubit.dart';
import 'package:usainua/pages/main_pages/order_pages/purchase_and_delivery_page/widgets/product_filling_form.dart';
import 'package:usainua/repositories/firestore_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/helpers/overlay_hints.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/select_widgets/select_delivery_method.dart';
import 'package:uuid/uuid.dart';

class PurchaseAndDeliveryPage extends StatefulWidget {
  const PurchaseAndDeliveryPage({Key? key}) : super(key: key);

  static const routeName = '/purchase_and_delivery_page';

  @override
  State<PurchaseAndDeliveryPage> createState() =>
      _PurchaseAndDeliveryPageState();
}

class _PurchaseAndDeliveryPageState extends State<PurchaseAndDeliveryPage> {
  final _overlayController = OverlayController();
  final _formKey = GlobalKey<FormState>();

  DeliveryMethod _deliveryMethod = DeliveryMethod.air;
  final _balanceController = TextEditingController(text: '1000\$');

  @override
  void dispose() {
    _overlayController.dispose();
    super.dispose();
  }

  final Map<UniqueKey, ProductFillingForm> _productFillingFormList = {};

  @override
  void initState() {
    UniqueKey uniqueKey = UniqueKey();
    _productFillingFormList[uniqueKey] = ProductFillingForm(
      key: uniqueKey,
      promptOverlayController: _overlayController,
      onDelete: () {
        _onFormDelete(uniqueKey);
      },
    );

    context
        .read<ProductFillingFormCubit>()
        .changeItemCount(_productFillingFormList.length);

    OverlayHints.initDotHint(
      context: context,
      overlayController: _overlayController,
    );
    context.read<NavigationBloc>().add(
          ChangeBottomNavigationBarStatus(
            showBottomNavBar: false,
          ),
        );
    super.initState();
  }

  void _onFormDelete(UniqueKey uniqueKey) {
    _productFillingFormList.removeWhere(
      (key, value) => key == uniqueKey,
    );
    context
        .read<ProductFillingFormCubit>()
        .changeItemCount(_productFillingFormList.length);
  }

  void _addNewForm() {
    UniqueKey uniqueKey = UniqueKey();
    _productFillingFormList[uniqueKey] = ProductFillingForm(
      key: uniqueKey,
      promptOverlayController: _overlayController,
      onDelete: () => _onFormDelete(uniqueKey),
    );
    context
        .read<ProductFillingFormCubit>()
        .changeItemCount(_productFillingFormList.length);
  }

  void _save() {
    final bool isFormValid = _formKey.currentState?.validate() ?? false;
    if (isFormValid) {
      final List<OrderModel> orderModels = [];

      _productFillingFormList.values.forEach(
        ((element) {
          final List<String> additionalServices =
              element.additionalServicesController.text.split(', ');

          print(additionalServices);
          orderModels.add(
            OrderModel(
              id: const Uuid().v4(),
              deliveryStatus: DeliveryStatus.operatorWaiting,
              deliveryMethod: _deliveryMethod,
              deliveryDate: DateTime.now(),
              link: element.linkController.text,
              count: element.countController.text,
              price: double.tryParse(element.costController.text),
              weight: double.tryParse(element.weightController.text),
              additionalServices: additionalServices.isNotEmpty &&
                      additionalServices[0].isNotEmpty
                  ? additionalServices
                  : null,
              description: element.descriptionController.text,
              dispatchType: DispatchType.purchaseAndDelivery,
            ),
          );
        }),
      );

      context.read<OrdersBloc>().add(
            AddOrdersEvent(orderModels: orderModels),
          );

      // FirestoreRepository.instance.createProduct(
      //   productModelList: productModelList,
      // );
    }
  }

  void _toogleExtendMode() {
    context.read<ProductFillingFormCubit>().toogleExtendMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          context.read<NavigationBloc>().add(
                ChangeBottomNavigationBarStatus(
                  showBottomNavBar: true,
                ),
              );
          Navigator.of(context).pop();
        },
        leadingIcon: SvgPicture.asset(
          AppIcons.leftArrow,
        ),
        text: 'Покупка и доставка',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _GreenDivider(),
              const SizedBox(height: 10),
              BlocBuilder<ProductFillingFormCubit, ProductFillingFormState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.isExtended)
                        SelectDeliveryMethod(
                          selectedDeliveryMethod: _deliveryMethod,
                          onChange: (value) {
                            setState(() {
                              _deliveryMethod = value;
                            });
                          },
                        ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: _productFillingFormList.values.toList(
                            growable: false,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      _ActionButtons(
                        isExpandMode: state.isExtended,
                        onaddNewItem: _addNewForm,
                        onswitchMode: _toogleExtendMode,
                      ),
                      const SizedBox(height: 25),
                      if (state.isExtended) ...[
                        _BalanceField(
                          controller: _balanceController,
                        ),
                        const SizedBox(height: 30),
                      ]
                    ],
                  );
                },
              ),
              SubmitButton(
                text: 'ДАЛЕЕ',
                onTap: _save,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _GreenDivider extends StatelessWidget {
  const _GreenDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 100,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.isExpandMode,
    required this.onaddNewItem,
    required this.onswitchMode,
    Key? key,
  }) : super(key: key);

  final bool isExpandMode;
  final VoidCallback onaddNewItem;
  final VoidCallback onswitchMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: onaddNewItem,
          icon: SvgPicture.asset(
            AppIcons.plus,
            color: AppColors.lightBlue,
          ),
          label: const Text(
            'Добавить еще один товар в просчет',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.bold,
              fontSize: AppFonts.sizeXSmall,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
          onPressed: onswitchMode,
          icon: SvgPicture.asset(
            isExpandMode ? AppIcons.leftArrowInBox : AppIcons.calculator,
            color: AppColors.lightBlue,
          ),
          label: Text(
            isExpandMode
                ? 'Вернуться к быстрой форме'
                : 'Ориентировочная стоимость',
            style: const TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.bold,
              fontSize: AppFonts.sizeXSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class _BalanceField extends StatelessWidget {
  const _BalanceField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Ориентировочная стоимость товара с доставкой: ',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontWeight: AppFonts.regular,
            fontSize: AppFonts.sizeXSmall,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: controller,
          style: const TextStyle(
            color: AppColors.darkBlue,
            fontSize: AppFonts.sizeXXLarge,
            fontWeight: AppFonts.heavy,
            letterSpacing: 0.5,
          ),
          readOnly: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(
              top: 12,
              bottom: 13,
              left: 21,
            ),
            filled: true,
            fillColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
