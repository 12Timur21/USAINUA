import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/sliders/warehouse_slider.dart';

void showWarehouseAdressesDialog({
  required BuildContext context,
}) {
  showDialog(
    context: context,
    barrierColor: AppColors.scaffold.withOpacity(0.9),
    builder: (context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary,
            ),
            child: Column(
              children: [
                const Expanded(
                  child: WarehouseSlider(
                    scrollDirection: Axis.vertical,
                    copyIconColor: AppColors.lightGreen,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '* - технику компании Apple можно отправлять только на дополнительный склад',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.regular,
                    letterSpacing: 1,
                    fontSize: AppFonts.sizeXSmall,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SubmitButton(
                  text: 'Назад',
                  textColor: Colors.white,
                  backgroundColor: AppColors.lightBlue,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
