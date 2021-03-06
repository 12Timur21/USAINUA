import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/models/payment_card_model.dart';
import 'package:usainua/repositories/firestore_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/credit_card_utils.dart';
import 'package:usainua/utils/formatters/card_month_input_formatter.dart';
import 'package:usainua/utils/formatters/card_number_input_formatter.dart';
import 'package:usainua/utils/helpers.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';
import 'package:uuid/uuid.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({Key? key}) : super(key: key);

  static const routeName = '/add_new_card_page';

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _creditCardNameController = TextEditingController(
    text: '44411144434942222',
  );
  final _validityPeriodController = TextEditingController();
  final _cvvController = TextEditingController();
  PaymentCardType? _cardType;

  void _getCardTypeFrmNumber() {
    String input = CreditCardUtils.getCleanedNumber(
      _creditCardNameController.text,
    );
    setState(() {
      _cardType = CreditCardUtils.getPaymentCardTypeFromNumber(input);
    });
  }

  void _validateAndSaveCreditCard() {
    final bool isValid = _formKey.currentState!.validate() && _cardType != null;
    if (isValid) {
      String month = _validityPeriodController.text.split('/').first;
      String year = _validityPeriodController.text.split('/').last;

      PaymentCardModel paymentCard = PaymentCardModel(
        id: const Uuid().v4(),
        type: _cardType,
        number: getIntFromString(
          _creditCardNameController.text,
        )!,
        month: int.parse(month),
        year: int.parse(year),
        cvv: int.parse(
          _cvvController.text,
        ),
      );

      FirestoreRepository.instance.saveUserPaymentCard(
        paymentCardModel: paymentCard,
      );

      Navigator.of(context).pop(paymentCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        text: '???????????????????? ??????????',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '?????? ???????????????????? ??????????, ?????? ???????????????? ?????????????? ?????????????? ???? ??????????????????',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.regular,
                fontSize: AppFonts.sizeXSmall,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              '?????????? ??????????',
              style: TextStyle(
                fontWeight: AppFonts.regular,
                fontSize: AppFonts.sizeXSmall,
                letterSpacing: 1,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _TextInput(
                    controller: _creditCardNameController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    suffixIcon: CreditCardUtils.getCardIcon(
                      paymentCardType: _cardType,
                      boxFit: BoxFit.scaleDown,
                    ),
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardNumberInputFormatter(),
                    ],
                    validator: CreditCardUtils.validateCardNumWithLuhnAlgorithm,
                    onChanged: (_) {
                      _getCardTypeFrmNumber();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichTextWrapper(
                    axis: Axis.horizontal,
                    textStyle: const TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: AppFonts.regular,
                      letterSpacing: 1,
                      fontSize: AppFonts.sizeXSmall,
                    ),
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '???????? ????????????????',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            _TextInput(
                                controller: _validityPeriodController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                hintText: 'MM/????',
                                formatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                  CardMonthInputFormatter(),
                                ],
                                validator: CreditCardUtils.validateDate,
                                onSubmitted: (value) {
                                  // List<int> expiryDate =
                                  //     CreditCardUtils.getExpiryDate(value);
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CVV',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            _TextInput(
                              controller: _cvvController,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              hintText: 'XXX',
                              validator: CreditCardUtils.validateCVV,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            SubmitButton(
              text: '??????????????????',
              onTap: _validateAndSaveCreditCard,
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.formatters,
    required this.keyboardType,
    required this.textInputAction,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? formatters;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final SvgPicture? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        onTap: onTap,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        cursorColor: AppColors.darkBlue,
        textInputAction: textInputAction,
        style: const TextStyle(
          color: AppColors.darkBlue,
          fontSize: AppFonts.sizeMedium,
        ),
        decoration: InputDecoration(
          suffixIcon: Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(
              right: 15,
            ),
            child: Center(
              child: suffixIcon,
            ),
          ),
          contentPadding: const EdgeInsets.only(
            left: 20,
            top: 10,
            bottom: 0,
          ),
          hintText: hintText,
          fillColor: AppColors.primary,
          filled: true,
        ),
      ),
    );
  }
}
