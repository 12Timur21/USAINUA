import 'package:flutter/material.dart';
import 'package:usainua/pages/main_pages/home_pages/tariff_page/tariff_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/designs/delivery_only_list.dart';
import 'package:usainua/widgets/text/text_in_box.dart';

class OnlyDeliveryInfromationPage extends StatelessWidget {
  const OnlyDeliveryInfromationPage({Key? key}) : super(key: key);

  static const routeName = '/only_delivery_information_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        onAction: () {},
        text: 'Только доставка',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            const TextInBox(
              backgroundColor: AppColors.primary,
              text:
                  'Текст о мейлфорвардинге и о том что мы доставим супер быстро но такие покупи менее защищены',
            ),
            const SizedBox(
              height: 30,
            ),
            const Expanded(
              child: DeliveryOnlyList(),
            ),
            const SizedBox(
              height: 60,
            ),
            SubmitButton(
              text: 'Рассчитать только доставку',
              backgroundColor: AppColors.lightBlue,
              textColor: Colors.white,
              onTap: () {
                Navigator.of(context).pushNamed(TariffPage.routeName,
                    arguments: DispatchType.deliveryOnly);
              },
            ),
          ],
        ),
      ),
    );
  }
}
