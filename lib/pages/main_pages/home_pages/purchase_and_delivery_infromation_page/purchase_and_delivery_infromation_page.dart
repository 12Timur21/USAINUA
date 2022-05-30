import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/designs/purchare_and_delivery_list.dart';
import 'package:usainua/widgets/text/text_in_box.dart';

class PurchaseAndDeliveryInfromationPage extends StatelessWidget {
  const PurchaseAndDeliveryInfromationPage({Key? key}) : super(key: key);

  static const routeName = '/purchase_and_delivery_information_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {},
        onAction: () {},
        text: 'Покупка и доставка',
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
              backgroundColor: AppColors.spreadLightGreen,
              text:
                  'Текст о безопастности и всем таком, что отличает покупку и доставку от просто доставки',
            ),
            const SizedBox(
              height: 30,
            ),
            const Expanded(
              child: PurchareAndDeliveryList(),
            ),
            const SizedBox(
              height: 60,
            ),
            SubmitButton(
              text: 'Рассчитать покупку и доставку',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
