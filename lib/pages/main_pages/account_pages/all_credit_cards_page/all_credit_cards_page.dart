import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:usainua/models/payment_card.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/card_utils.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';

import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';

class AllCreditCardsPage extends StatefulWidget {
  const AllCreditCardsPage({Key? key}) : super(key: key);

  static const routeName = '/all_credit_cards_page';

  @override
  State<AllCreditCardsPage> createState() => _AllCreditCardsPageState();
}

class _AllCreditCardsPageState extends State<AllCreditCardsPage> {
  final List<PaymentCard> _paymentCard = const [
    PaymentCard(
      type: PaymentCardType.masterCard,
      number: 123456781234,
      month: 12,
      year: 13,
      cvv: 123,
    ),
    PaymentCard(
      type: PaymentCardType.visa,
      number: 124444671234,
      month: 04,
      year: 01,
      cvv: 144,
    ),
  ];

  late PaymentCard _selectedCard;

  @override
  void initState() {
    _selectedCard = _paymentCard[0];

    super.initState();
  }

  bool isAutomaticWriteOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {},
        onAction: () {},
        text: 'Банковские карты',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            Column(
              children: [
                _creditCard(
                  value: _paymentCard[0],
                  groupValue: _selectedCard,
                  onChanged: (value) {
                    setState(() {
                      _selectedCard = value;
                    });
                  },
                ),
                _creditCard(
                  value: _paymentCard[1],
                  groupValue: _selectedCard,
                  onChanged: (value) {
                    setState(() {
                      _selectedCard = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            IconTextButton(
              onTap: () {},
              textStyle: const TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.bold,
                fontSize: AppFonts.sizeSmall,
              ),
              text: 'Добавить еще карту',
              icon: SvgPicture.asset(
                AppIcons.plus,
                color: AppColors.lightBlue,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  onTap: () {},
                  textStyle: const TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.bold,
                    fontSize: AppFonts.sizeSmall,
                  ),
                  text: 'Автосписывание по умолчанию',
                  icon: SvgPicture.asset(
                    AppIcons.question,
                    color: AppColors.lightBlue,
                  ),
                ),
                FlutterSwitch(
                  width: 60,
                  height: 30,
                  toggleSize: 25,
                  valueFontSize: 25.0,
                  activeText: '',
                  inactiveText: '',
                  activeColor: AppColors.antiFlashWhite,
                  inactiveColor: AppColors.antiFlashWhite,
                  value: isAutomaticWriteOff,
                  borderRadius: 30.0,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      isAutomaticWriteOff = val;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _creditCard({
  required PaymentCard value,
  required PaymentCard groupValue,
  required Function(PaymentCard) onChanged,
}) {
  String updatedCardNumber0 = value.number.toString().replaceAllMapped(
        RegExp(r".{4}"),
        (match) => "${match.group(0)} ",
      );

  String updatedCardNumber = '';
  updatedCardNumber += updatedCardNumber0.substring(
    0,
    7,
  );
  updatedCardNumber += ' ... ';
  updatedCardNumber += updatedCardNumber0.substring(
    updatedCardNumber0.length - 5,
  );

  SvgPicture cardIcon = CardUtils.getCardIcon(
    paymentCardType: value.type,
  );

  return Container(
    height: 80,
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
    margin: const EdgeInsets.only(
      top: 10,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 24,
    ),
    child: Row(
      children: [
        Row(
          children: [
            CustomRadioOption<PaymentCard>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              updatedCardNumber,
              style: const TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.heavy,
                fontSize: AppFonts.sizeLarge,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const Spacer(),
        cardIcon,
      ],
    ),
  );
}
