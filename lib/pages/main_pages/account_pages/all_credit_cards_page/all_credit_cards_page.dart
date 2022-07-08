import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:usainua/models/payment_card_model.dart';
import 'package:usainua/pages/main_pages/account_pages/add_new_card_page/add_new_card_page.dart';
import 'package:usainua/repositories/firestore_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/utils/credit_card_utils.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';
import 'package:collection/collection.dart';

class AllCreditCardsPage extends StatefulWidget {
  const AllCreditCardsPage({Key? key}) : super(key: key);

  static const routeName = '/all_credit_cards_page';

  @override
  State<AllCreditCardsPage> createState() => _AllCreditCardsPageState();
}

class _AllCreditCardsPageState extends State<AllCreditCardsPage> {
  final List<PaymentCardModel> _paymentCards = [];
  PaymentCardModel? _selectedCard;
  bool _isAutomaticWriteOff = false;

  @override
  void initState() {
    _asyncInit();
    super.initState();
  }

  Future<void> _asyncInit() async {
    List<PaymentCardModel>? paymentCardModels =
        await FirestoreRepository.instance.getAllPaymentCards();
    if (paymentCardModels != null) {
      _paymentCards.addAll(paymentCardModels);
    }

    PaymentCardModel? activePaymentCard = await _getActivePaymentCardID();
    bool? isAutomaticWriteOff = await _getAutomaticWriteOffStatus();
    setState(() {
      _selectedCard = activePaymentCard;
      _isAutomaticWriteOff = isAutomaticWriteOff ?? false;
    });
  }

  void _changeAutomaticWriteOffStatus(bool status) {
    setState(() {
      _isAutomaticWriteOff = status;
    });
    FirestoreRepository.instance.setAutomaticWriteOffStatus(
      _isAutomaticWriteOff,
    );
  }

  void _setActivePaymentCard(PaymentCardModel value) {
    setState(() {
      _selectedCard = value;
    });
    FirestoreRepository.instance.setActivePaymentCardID(value.id);
  }

  Future<PaymentCardModel?> _getActivePaymentCardID() async {
    String? id = await FirestoreRepository.instance.getActivePaymentCardID();

    PaymentCardModel? selectedCard = _paymentCards.firstWhereOrNull(
      (element) {
        print(element.id);
        print(id);
        return element.id == id;
      },
    );
    // print(id);
    // print(selectedCard);

    return selectedCard;
  }

  Future<bool?> _getAutomaticWriteOffStatus() async {
    bool? isActive =
        await FirestoreRepository.instance.getAutomaticWriteOffStatus();

    return isActive;
  }

  Future<void> _addNewPaymentCard() async {
    PaymentCardModel? paymentCardModel = await Navigator.of(context).pushNamed(
      AddNewCardPage.routeName,
    ) as PaymentCardModel?;

    if (paymentCardModel != null) {
      setState(() {
        _paymentCards.add(paymentCardModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        text: 'Банковские карты',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            ListView.builder(
              itemCount: _paymentCards.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _CreditCard(
                  value: _paymentCards[index],
                  groupValue: _selectedCard,
                  onChanged: _setActivePaymentCard,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            IconTextButton(
              onTap: _addNewPaymentCard,
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
                Expanded(
                  child: IconTextButton(
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
                ),
                SizedBox(
                  width: 60,
                  child: FlutterSwitch(
                    width: 60,
                    height: 30,
                    toggleSize: 25,
                    valueFontSize: 25.0,
                    activeText: '',
                    inactiveText: '',
                    activeColor: AppColors.antiFlashWhite,
                    inactiveColor: AppColors.antiFlashWhite,
                    value: _isAutomaticWriteOff,
                    borderRadius: 30.0,
                    showOnOff: true,
                    onToggle: _changeAutomaticWriteOffStatus,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  const _CreditCard({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final PaymentCardModel value;
  final PaymentCardModel? groupValue;
  final Function(PaymentCardModel) onChanged;

  @override
  Widget build(BuildContext context) {
    String updatedCardNumber0 = value.number.toString().replaceAllMapped(
          RegExp(r'.{4}'),
          (match) => '${match.group(0)} ',
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

    SvgPicture cardIcon = CreditCardUtils.getCardIcon(
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
              CustomRadioOption<PaymentCardModel>(
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
}
