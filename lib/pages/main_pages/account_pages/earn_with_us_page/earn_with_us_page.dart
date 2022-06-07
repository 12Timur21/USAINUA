import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';

class EarnWithUsPage extends StatelessWidget {
  const EarnWithUsPage({Key? key}) : super(key: key);

  static const routeName = '/earn_with_us_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        onAction: () {},
        text: 'Зарабатывайте c нами',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _referralProgramCard(),
              _infoCard(
                title: '200 грн за распаковку',
                text:
                    'Запишите видеоролик или сделайте фото распаковки, выложите его на youtube и в нашей группе Facebook.',
                image: Image.asset(
                  AppImages.boxSurprise,
                ),
              ),
              _infoCard(
                title: 'Кешбэк',
                text:
                    'Мы  запустили  первый в  Украине  кешбэк для  доставки товаров  из  США  и Европы. Покупать за рубежом стало еще выгоднее и приятнее!',
                image: Image.asset(
                  AppImages.girlWithWallet,
                ),
                alignment: Alignment.centerRight,
              ),
              _infoCard(
                title: 'Фулфилмент',
                text:
                    'Вы концентрируетесь на самом важном —  привлечении клиентов и заказов, а мы берем на себя рутину, которую за 7 лет выучили до мелочей, доставив более 1 млн. товаров.',
                image: Image.asset(
                  AppImages.warehouseWithMan,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _infoCard({
  required String title,
  required String text,
  required Image image,
  Alignment alignment = Alignment.center,
}) {
  return Container(
    margin: const EdgeInsets.only(
      top: 20,
    ),
    padding: const EdgeInsets.only(
      left: 20,
      right: 20,
      top: 15,
    ),
    decoration: BoxDecoration(
      color: AppColors.littleGray,
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              AppIcons.filledStar,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.bold,
                fontSize: AppFonts.sizeSmall,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Запишите видеоролик или сделайте фото распаковки, выложите его на youtube и в нашей группе Facebook.',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontWeight: AppFonts.regular,
            fontSize: AppFonts.sizeXSmall,
          ),
        ),
        Align(
          alignment: alignment,
          child: image,
        ),
      ],
    ),
  );
}

Widget _referralProgramCard() {
  return Container(
    height: 90,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
    child: Row(
      children: [
        Image.asset(
          AppImages.peopleWithMoney,
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'Реферальная программа',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontWeight: AppFonts.bold,
            fontSize: AppFonts.sizeSmall,
          ),
        ),
      ],
    ),
  );
}
