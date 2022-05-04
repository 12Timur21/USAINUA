import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/text/icon_text.dart';
import 'package:usainua/widgets/text/rich_text_widget.dart';

class FourthSliderPage extends StatefulWidget {
  const FourthSliderPage({Key? key}) : super(key: key);

  @override
  State<FourthSliderPage> createState() => _FourthSliderPageState();
}

class _FourthSliderPageState extends State<FourthSliderPage> {
  bool isOnlyDelivery = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 35,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isOnlyDelivery = false;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 8,
                              color: !isOnlyDelivery
                                  ? AppColors.buttonPrimary
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Покупка и доставка',
                            style: TextStyle(
                              color: !isOnlyDelivery
                                  ? AppColors.textPrimary
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isOnlyDelivery = true;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 8,
                              color: isOnlyDelivery
                                  ? AppColors.buttonSecondary
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Только доставка',
                            style: TextStyle(
                              color: isOnlyDelivery
                                  ? AppColors.textPrimary
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          isOnlyDelivery ? _deliveryOnly() : _purchareAndDelivery(),
        ],
      ),
    );
  }
}

Widget _purchareAndDelivery() {
  return SizedBox(
    height: 400,
    child: RichTextWidgets(
      textStyle: const TextStyle(
        color: AppColors.textPrimary,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconText(
          icon: SvgPicture.asset(
            AppIcons.basket,
          ),
          iconPadding: const EdgeInsets.only(
            right: 30,
          ),
          label: 'Выберите желаемые товары в интернет-магазинах США/Европы.',
        ),
        IconText(
          icon: SvgPicture.asset(
            AppIcons.copy,
          ),
          iconPadding: const EdgeInsets.only(
            right: 30,
          ),
          label: 'Скопируйте ссылки на выбранные товары в форму заказа.',
        ),
        IconText(
          icon: SvgPicture.asset(
            AppIcons.moneyBag,
          ),
          iconPadding: const EdgeInsets.only(
            right: 30,
          ),
          label:
              'В течение 30 минут в кабинете появится расчёт стоимости покупки товаров с доставкой.',
        ),
        IconText(
          icon: SvgPicture.asset(
            AppIcons.location,
          ),
          iconPadding: const EdgeInsets.only(
            right: 30,
          ),
          label:
              'Мы выкупим Ваш заказ, и привезем его к Вам. Вы сможете отслеживать его в личном кабинете.',
        ),
      ],
    ),
  );
}

Widget _deliveryOnly() {
  return SizedBox(
    height: 400,
    child: RichTextWidgets(
      textStyle: const TextStyle(
        color: AppColors.textPrimary,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconText(
          icon: SvgPicture.asset(
            AppIcons.copy_2,
            color: AppColors.textSecondary,
          ),
          iconPadding: const EdgeInsets.only(
            right: 30,
          ),
          label:
              'Скопируйте адреса складов, на которые Вы сможете доставлять самостоятельно купленные заказы',
        ),
        IconText(
          icon: SvgPicture.asset(
            AppIcons.edit,
            color: AppColors.textSecondary,
          ),
          iconPadding: const EdgeInsets.only(
            right: 30,
          ),
          label: 'Введите трекинг-номер, полученный от магазина.',
        ),
        IconText(
          icon: SvgPicture.asset(
            AppIcons.moneyBag,
            color: AppColors.textSecondary,
          ),
          iconPadding: const EdgeInsets.only(
            right: 30,
          ),
          label: 'Выберите способ доставки и оплатите заказ',
        ),
        IconText(
          icon: SvgPicture.asset(
            AppIcons.location,
            color: AppColors.textSecondary,
          ),
          iconPadding: const EdgeInsets.only(
            right: 30,
          ),
          label:
              'Теперь остается всего немного подождать, и посылка у Вас! PS.... можете отслеживать ее в своем кабинете',
        ),
      ],
    ),
  );
}
