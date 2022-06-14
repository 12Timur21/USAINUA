import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/text/icon_text.dart';

class TrackingTab extends StatelessWidget {
  const TrackingTab({Key? key}) : super(key: key);

  final List<String> _stagesList = const [
    'Расчет стоимости',
    'Готов к оплате',
    'Оплачено, в обработке',
    'Ожидаем доставку на склад США',
    'Доставлено на склад США / Европы',
    'Отправлено в Украине',
    'Поступило в Украину',
    'Отправлено по Украине / готово к самовывозу',
    'Заказ доставлен',
  ];

  List<Widget> selectCurrentStage({
    required String currentStatus,
  }) {
    Widget _textPassedStage(String text) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.noActiveText,
            fontWeight: AppFonts.bold,
            fontSize: AppFonts.sizeXSmall,
          ),
        ),
      );
    }

    Widget _textNotPassedStage(String text) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.antiFlashWhite,
            fontWeight: AppFonts.bold,
            fontSize: AppFonts.sizeXSmall,
          ),
        ),
      );
    }

    Widget _textCurrentStage(String text) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: IconText(
          icon: SvgPicture.asset(
            AppIcons.rightArrow,
            color: AppColors.lightBlue,
          ),
          iconPadding: const EdgeInsets.only(right: 10),
          label: text,
          textStyle: const TextStyle(
            color: AppColors.lightBlue,
            fontWeight: AppFonts.bold,
            fontSize: AppFonts.sizeXSmall,
          ),
        ),
      );
    }

    bool isAlreadyFound = false;

    List<Widget> statusList = [];

    for (String status in _stagesList) {
      if (status == currentStatus) {
        isAlreadyFound = true;
        statusList.add(
          _textCurrentStage(status),
        );
      } else if (isAlreadyFound) {
        statusList.add(
          _textNotPassedStage(status),
        );
      } else {
        statusList.add(
          _textPassedStage(status),
        );
      }
    }

    return statusList;
  }

  @override
  Widget build(BuildContext context) {
    final _balanceController = TextEditingController(text: 'ТТН ХХХХХХХХХХ');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...selectCurrentStage(
              currentStatus: _stagesList[5],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Ориентировочная дата получения заказа 13.12.20',
              style: TextStyle(
                color: AppColors.lightBlue,
                fontWeight: AppFonts.bold,
                fontSize: AppFonts.sizeXSmall,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _balanceController,
              style: const TextStyle(
                color: AppColors.darkBlue,
                fontSize: AppFonts.sizeSmall,
                fontWeight: AppFonts.bold,
                letterSpacing: 0.5,
              ),
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 12,
                  bottom: 13,
                  left: 21,
                ),
                filled: true,
                fillColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
