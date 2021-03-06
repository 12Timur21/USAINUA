import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/pages/main_pages/order_pages/our_choise_page/widget/category_slider.dart';
import 'package:usainua/pages/main_pages/order_pages/our_choise_page/widget/company_choise_slider.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/services/web_scrapping_service.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/widgets/sliders/goods_slider.dart';

class OurChoisePage extends StatefulWidget {
  const OurChoisePage({Key? key}) : super(key: key);

  static const routeName = '/our_choise_page';

  @override
  State<OurChoisePage> createState() => _OurChoisePageState();
}

class _OurChoisePageState extends State<OurChoisePage> {
  WebsiteSections _websiteSection = WebsiteSections.popular;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Наш выбор',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.heavy,
                  fontSize: AppFonts.sizeXXLarge,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CategorySlider(
                activeCategory: _websiteSection,
                onChange: (WebsiteSections value) {
                  setState(() {
                    _websiteSection = value;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              GoodsSlider(
                webCite: WebCites.ebay,
                websiteSection: _websiteSection,
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                'Шоппинг - моллы',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeSmall,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CompanyChoiseSlider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '100 тыс. ',
                          style: TextStyle(
                            color: AppColors.lightBlue,
                            fontWeight: AppFonts.bold,
                            letterSpacing: 0.5,
                            fontSize: AppFonts.sizeSmall,
                          ),
                        ),
                        TextSpan(
                          text: 'успешных заказов',
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontWeight: AppFonts.regular,
                            letterSpacing: 0.51,
                            fontSize: AppFonts.sizeXSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    AppIcons.threeDollars,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Онлайн площадка для проведения аукционов и торговый сайт, на котором частные и юридические лица осуществляют продажу и покупку различных товаров и услуг.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
