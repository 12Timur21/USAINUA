import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/models/warehouse_model.dart';
import 'package:usainua/repositories/strapi_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/helpers/in_app_notification.dart';
import 'package:usainua/widgets/buttons/icon_text_button_with_label.dart';

class WarehouseSlider extends StatelessWidget {
  const WarehouseSlider({
    this.scrollDirection = Axis.horizontal,
    this.copyIconColor = AppColors.lightBlue,
    Key? key,
  }) : super(key: key);

  final Axis scrollDirection;
  final Color copyIconColor;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StrapiRepository().getWarehouses(),
      builder: (context, AsyncSnapshot<List<WarehouseModel>> data) {
        if (data.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }

        if (data.connectionState == ConnectionState.done) {
          if (data.hasError) {
            return const Center(
              child: Text(
                'Не удалось получить данные',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: data.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    right: scrollDirection == Axis.horizontal && index == 3
                        ? 10
                        : 24,
                    bottom:
                        scrollDirection == Axis.vertical && index == 3 ? 10 : 0,
                  ),
                  width: 300,
                  child: _WarehouseCard(
                    copyIconColor: copyIconColor,
                    warehouseModel: data.data![index],
                  ),
                );
              },
            );
          }
        }

        return Container();
      },
    );
  }
}

class _WarehouseCard extends StatelessWidget {
  const _WarehouseCard({
    required this.warehouseModel,
    required this.copyIconColor,
    Key? key,
  }) : super(key: key);

  final WarehouseModel warehouseModel;
  final Color copyIconColor;

  final TextStyle _labelStyle = const TextStyle(
    color: AppColors.darkBlue,
    letterSpacing: 1,
    fontSize: AppFonts.sizeXSmall,
    fontWeight: AppFonts.regular,
  );

  final TextStyle _textStyle = const TextStyle(
    color: AppColors.darkBlue,
    fontWeight: AppFonts.bold,
    fontSize: AppFonts.sizeSmall,
    letterSpacing: 0.5,
  );

  void _copyToBuffer(String value) {
    Clipboard.setData(
      ClipboardData(text: value),
    );
    InAppNotification.show(
      title: 'Скопировано в буфер',
      type: InAppNotificationType.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              warehouseModel.warehouseName,
              style: const TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.heavy,
                letterSpacing: 0.5,
                fontSize: AppFonts.sizeXXLarge,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ФИО',
                  style: _labelStyle,
                ),
                Text(
                  warehouseModel.fullName,
                  style: _textStyle,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: IconTextButtonWithLabel(
                isReverse: true,
                onTap: (() {
                  _copyToBuffer(warehouseModel.street);
                }),
                label: 'Улица',
                text: warehouseModel.street,
                textOverflow: TextOverflow.ellipsis,
                icon: SvgPicture.asset(
                  AppIcons.copy_3,
                  color: copyIconColor,
                ),
                labelStyle: _labelStyle,
                textStyle: _textStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: IconTextButtonWithLabel(
                isReverse: true,
                onTap: (() {
                  _copyToBuffer(warehouseModel.city);
                }),
                label: 'Город',
                text: warehouseModel.city,
                textOverflow: TextOverflow.ellipsis,
                icon: SvgPicture.asset(
                  AppIcons.copy_3,
                  color: copyIconColor,
                ),
                labelStyle: _labelStyle,
                textStyle: _textStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: IconTextButtonWithLabel(
                isReverse: true,
                onTap: (() {
                  _copyToBuffer(warehouseModel.state);
                }),
                label: 'Штат',
                text: warehouseModel.state,
                textOverflow: TextOverflow.ellipsis,
                icon: SvgPicture.asset(
                  AppIcons.copy_3,
                  color: copyIconColor,
                ),
                labelStyle: _labelStyle,
                textStyle: _textStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: IconTextButtonWithLabel(
                isReverse: true,
                onTap: (() {
                  _copyToBuffer(warehouseModel.index);
                }),
                label: 'Индекс',
                text: warehouseModel.index,
                textOverflow: TextOverflow.ellipsis,
                icon: SvgPicture.asset(
                  AppIcons.copy_3,
                  color: copyIconColor,
                ),
                labelStyle: _labelStyle,
                textStyle: _textStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: IconTextButtonWithLabel(
                isReverse: true,
                onTap: (() {
                  _copyToBuffer(warehouseModel.phoneNumber);
                }),
                label: 'Телефон',
                text: PhoneInputFormatter().mask(
                  warehouseModel.phoneNumber,
                ),
                textOverflow: TextOverflow.ellipsis,
                icon: SvgPicture.asset(
                  AppIcons.copy_3,
                  color: copyIconColor,
                ),
                labelStyle: _labelStyle,
                textStyle: _textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
