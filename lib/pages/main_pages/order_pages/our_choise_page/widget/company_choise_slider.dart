import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usainua/models/shopping_malls_model.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/utils/helpers/in_app_notification.dart';

class CompanyChoiseSlider extends StatelessWidget {
  const CompanyChoiseSlider({Key? key}) : super(key: key);

  void selectCategory(String selectedCategory) {}

  @override
  Widget build(BuildContext context) {
    const List<ShoppingMallsModel> _shoppingMallsList = [
      ShoppingMallsModel(
        mallName: 'ebay',
        linkUrl: 'https://www.ebay.com/',
        imageUrl: AppImages.ebay,
      ),
      ShoppingMallsModel(
        mallName: 'amazon',
        linkUrl: 'https://www.amazon.com/',
        imageUrl: AppImages.amazon,
      ),
      ShoppingMallsModel(
        mallName: 'walmart',
        linkUrl: 'https://www.walmart.com/',
        imageUrl: AppImages.walmart,
      ),
      ShoppingMallsModel(
        mallName: 'macys',
        linkUrl: 'https://www.macys.com/',
        imageUrl: AppImages.macys,
      ),
    ];

    Future<void> _openLink(String link) async {
      final Uri url = Uri.parse(link);

      bool isOpenedSuccessfully = await launchUrl(url);
      if (!isOpenedSuccessfully) {
        InAppNotification.show(
          title: 'Не удалось открыть ссылку',
          type: InAppNotificationType.error,
        );
      }
    }

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _shoppingMallsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: index == 0
                ? EdgeInsets.zero
                : const EdgeInsets.only(
                    left: 10,
                  ),
            child: GestureDetector(
              onTap: () {
                _openLink(
                  _shoppingMallsList[index].linkUrl,
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    _shoppingMallsList[index].imageUrl,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
