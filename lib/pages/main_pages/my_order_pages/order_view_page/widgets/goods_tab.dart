import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';
import 'package:usainua/widgets/text/icon_text_with_label.dart';

class GoodsTab extends StatelessWidget {
  const GoodsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 4,
        itemBuilder: ((context, index) {
          return Container(
            margin: EdgeInsets.only(
              top: index == 0 ? 0 : 10,
            ),
            child: _orderCard(
              deliveryDate: DateTime.now(),
              link: 'https://www.macys.com/...',
              count: 2,
              additionalServices: [
                AdditionalServices.additionalPackaging,
                AdditionalServices.inclusionCheck,
              ],
              trackNumber: '9400116901639555951023',
              description: 'Qty: 1 Color: Navy Size: M',
            ),
          );
        }),
      ),
    );
  }
}

//TODO переделать на Model
Widget _orderCard({
  required DateTime deliveryDate,
  required String link,
  required int count,
  List<AdditionalServices>? additionalServices,
  required String trackNumber,
  String? description,
}) {
  return Container(
    height: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        width: 2,
        color: AppColors.primary,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTextWithLabel(
            label: 'Заказ доставлен ${DateFormat('dd.MM.yyyy').format(
              deliveryDate,
            )}',
            text: link,
            labelStyle: const TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.bold,
              fontSize: AppFonts.sizeSmall,
              letterSpacing: 0.5,
            ),
            textStyle: const TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.regular,
              fontSize: AppFonts.sizeXSmall,
              letterSpacing: 1,
            ),
            icon: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.bag,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Количество:',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.regular,
                  fontSize: AppFonts.sizeXSmall,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '$count шт',
                style: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Доп. услуги:',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.regular,
                  fontSize: AppFonts.sizeXSmall,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Фото товару, додаткове пакування, перевірка на увімк/вимк',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.bold,
                    fontSize: AppFonts.sizeXSmall,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Трек номер:',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.regular,
                  fontSize: AppFonts.sizeXSmall,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                trackNumber,
                style: const TextStyle(
                  color: AppColors.lightBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Комментарий к товару',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.regular,
              fontSize: AppFonts.sizeXSmall,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  description ?? '',
                  style: const TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: AppFonts.regular,
                    fontSize: AppFonts.sizeXSmall,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
