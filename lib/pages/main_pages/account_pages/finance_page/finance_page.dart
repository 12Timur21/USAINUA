import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';

import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/check_boxes/custom_checkbox.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({Key? key}) : super(key: key);

  static const routeName = '/finance_page';

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final TextEditingController _balanceController = TextEditingController();
  bool _isAutomaticallyWriteOffDebts = false;

  void _pop() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {},
        onAction: () {},
        text: 'Финансы',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          children: [
            const Text(
              'Ваш баланс',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.bold,
                letterSpacing: 0.5,
                fontSize: AppFonts.sizeXLarge,
              ),
            ),
            TextFormField(
              controller: _balanceController,
              style: const TextStyle(
                color: AppColors.darkBlue,
                fontSize: AppFonts.sizeXXLarge,
                fontWeight: AppFonts.heavy,
                letterSpacing: 0.5,
              ),
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  onTap: () {},
                  text: 'Вывести с баланса',
                  icon: SvgPicture.asset(
                    AppIcons.upload,
                  ),
                ),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: SubmitButton(
                    onTap: () {},
                    text: 'Пополнить',
                    borderRadius: BorderRadius.circular(
                      40,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCheckbox(
                        isActive: _isAutomaticallyWriteOffDebts,
                        activeColor: AppColors.lightBlue,
                        backgroundColor: AppColors.primary,
                        onChanged: (value) {
                          _isAutomaticallyWriteOffDebts = value;
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(
                        child: Text(
                          'Автоматически списывать с баланса задолженности до 50\$.',
                          maxLines: 2,
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontWeight: AppFonts.regular,
                            fontSize: AppFonts.sizeXSmall,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: SvgPicture.asset(
                    AppIcons.question,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Платежные операции',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.heavy,
                letterSpacing: 0.5,
                fontSize: AppFonts.sizeLarge,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    paymentCard(
                      id: '1231212',
                      dateTime: DateTime.now(),
                      price: 123.23,
                      operationType: OperationType.orderPayment,
                      paymentMethod: PaymentMethod.balance,
                    ),
                    paymentCard(
                      id: '312312312',
                      dateTime: DateTime.now(),
                      price: 12,
                      operationType: OperationType.orderPayment,
                      paymentMethod: PaymentMethod.balance,
                    ),
                    paymentCard(
                      id: '4444',
                      dateTime: DateTime.now(),
                      price: 1444,
                      operationType: OperationType.orderPayment,
                      paymentMethod: PaymentMethod.balance,
                    ),
                    paymentCard(
                      id: '888775',
                      dateTime: DateTime.now(),
                      price: 431,
                      operationType: OperationType.orderPayment,
                      paymentMethod: PaymentMethod.balance,
                    ),
                    paymentCard(
                      id: '1231212',
                      dateTime: DateTime.now(),
                      price: 1,
                      operationType: OperationType.orderPayment,
                      paymentMethod: PaymentMethod.balance,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum OperationType {
  orderPayment,
}

enum PaymentMethod {
  balance,
}

Widget paymentCard({
  required String id,
  required DateTime dateTime,
  required double price,
  required OperationType operationType,
  required PaymentMethod paymentMethod,
}) {
  late final String operationTypeText;
  late final String paymentMethodText;
  switch (operationType) {
    case OperationType.orderPayment:
      operationTypeText = 'Оплата заказа';
      break;
    default:
      operationTypeText = 'Неизвестный тип заказа';
  }

  switch (paymentMethod) {
    case PaymentMethod.balance:
      paymentMethodText = 'Баланс';
      break;
    default:
      paymentMethodText = 'Неизвестный тип оплаты';
  }

  return Container(
    height: 100,
    decoration: BoxDecoration(
      border: Border.all(
        width: 2,
        color: AppColors.primary,
      ),
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
    padding: const EdgeInsets.all(15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichTextWrapper(
          axis: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textStyle: const TextStyle(
            color: AppColors.darkBlue,
            fontWeight: AppFonts.regular,
            fontSize: AppFonts.sizeXSmall,
            letterSpacing: 1,
          ),
          children: [
            IconTextButton(
              onTap: () {},
              text: id,
              icon: SvgPicture.asset(
                AppIcons.id,
              ),
            ),
            IconTextButton(
              onTap: () {},
              text: DateFormat('dd/MM/yy').format(dateTime),
              icon: SvgPicture.asset(
                AppIcons.calendar,
              ),
            ),
            IconTextButton(
              onTap: () {},
              text: price.toString(),
              icon: SvgPicture.asset(
                AppIcons.moneyBag,
                color: AppColors.lightBlue,
              ),
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Тип операции  ',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.regular,
                  fontSize: AppFonts.sizeXSmall,
                  letterSpacing: 1,
                ),
              ),
              TextSpan(
                text: operationTypeText,
                style: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeSmall,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Способ  ',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.regular,
                  fontSize: AppFonts.sizeXSmall,
                  letterSpacing: 1,
                ),
              ),
              TextSpan(
                text: paymentMethodText,
                style: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeSmall,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    // child: ,
  );
}
