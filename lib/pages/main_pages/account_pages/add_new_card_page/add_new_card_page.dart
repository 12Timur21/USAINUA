import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/credit_card_utils.dart';
import 'package:usainua/utils/formatters/card_month_input_formatter.dart';
import 'package:usainua/utils/formatters/card_number_input_formatter.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({Key? key}) : super(key: key);

  static const routeName = '/add_new_card_page';

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _creditCardNameController = TextEditingController(
    text: '5480583688604670',
  );

  final TextEditingController _validityPeriodController =
      TextEditingController();

  final TextEditingController _cvvController = TextEditingController();

  PaymentCardType? _cardType;

  void _getCardTypeFrmNumber() {
    String input =
        CreditCardUtils.getCleanedNumber(_creditCardNameController.text);
    setState(() {
      _cardType = CreditCardUtils.getPaymentCardTypeFromNumber(input);
    });
  }

  void _validateAndSaveCreditCard() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        onAction: () {},
        text: 'Банковские карты',
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
              'Для добавления карты, как средства платежа введите ее реквизиты',
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
              'Номер карты',
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
                  _textInput(
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
                      validator:
                          CreditCardUtils.validateCardNumWithLuhnAlgorithm,
                      onChanged: (_) {
                        _getCardTypeFrmNumber();
                      },
                      onSubmitted: (value) {
                        // print(
                        //   CreditCardUtils.getCleanedNumber(
                        //     value,
                        //   ),
                        // );
                      }),
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
                              'Срок действия',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            _textInput(
                                controller: _validityPeriodController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                hintText: 'MM/ГГ',
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
                            _textInput(
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
              text: 'Сохранить',
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

Widget _textInput({
  required TextEditingController controller,
  String? hintText,
  String? Function(String?)? validator,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  VoidCallback? onTap,
  List<TextInputFormatter>? formatters,
  required TextInputType keyboardType,
  required TextInputAction textInputAction,
  SvgPicture? suffixIcon,
}) {
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
