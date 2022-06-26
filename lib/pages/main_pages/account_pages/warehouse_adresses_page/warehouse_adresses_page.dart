import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';

import 'package:usainua/widgets/sliders/warehouse_slider.dart';

class WarehouseAdressesPage extends StatelessWidget {
  const WarehouseAdressesPage({Key? key}) : super(key: key);

  static const routeName = '/warhouse_adresses_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        text: 'Адреса складов',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          left: 24,
        ),
        child: Column(
          children: const [
            Expanded(
              child: WarehouseSlider(),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '* - технику компании Apple можно отправлять только на дополнительный склад',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.regular,
                letterSpacing: 1,
                fontSize: AppFonts.sizeXSmall,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
