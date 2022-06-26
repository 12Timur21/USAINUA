import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/text/icon_text.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';

class PurchareAndDeliveryList extends StatelessWidget {
  const PurchareAndDeliveryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichTextWrapper(
      textStyle: const TextStyle(
        color: AppColors.darkBlue,
        fontWeight: AppFonts.regular,
        fontSize: AppFonts.sizeXSmall,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}
