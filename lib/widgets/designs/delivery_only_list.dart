import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/text/icon_text.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';

class DeliveryOnlyList extends StatelessWidget {
  const DeliveryOnlyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: RichTextWrapper(
        textStyle: const TextStyle(
          color: AppColors.darkBlue,
          fontWeight: AppFonts.regular,
          fontSize: AppFonts.sizeXSmall,
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconText(
            icon: SvgPicture.asset(
              AppIcons.copy_2,
              color: AppColors.lightBlue,
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
              color: AppColors.lightBlue,
            ),
            iconPadding: const EdgeInsets.only(
              right: 30,
            ),
            label: 'Введите трекинг-номер, полученный от магазина.',
          ),
          IconText(
            icon: SvgPicture.asset(
              AppIcons.moneyBag,
              color: AppColors.lightBlue,
            ),
            iconPadding: const EdgeInsets.only(
              right: 30,
            ),
            label: 'Выберите способ доставки и оплатите заказ',
          ),
          IconText(
            icon: SvgPicture.asset(
              AppIcons.location,
              color: AppColors.lightBlue,
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
}
