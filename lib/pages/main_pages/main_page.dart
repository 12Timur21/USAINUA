import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:usainua/pages/main_pages/account_pages/account_page/account_page.dart';
import 'package:usainua/pages/main_pages/account_pages/all_credit_cards_page/all_credit_cards_page.dart';
import 'package:usainua/pages/main_pages/account_pages/earn_with_us_page/earn_with_us_page.dart';
import 'package:usainua/pages/main_pages/account_pages/finance_page/finance_page.dart';
import 'package:usainua/pages/main_pages/account_pages/personal_data_page/personal_data_page.dart';
import 'package:usainua/pages/main_pages/home_pages/home_page/home_page.dart';
import 'package:usainua/pages/main_pages/my_order_page/my_order_page.dart';
import 'package:usainua/pages/main_pages/order_pages/our_choise_page/out_choice_page.dart';
import 'package:usainua/pages/main_pages/order_pages/purchase_and_delivery_page/purchase_and_delivery_page.dart';
import 'package:usainua/pages/splash_screen_page/splash_screen_page.dart';

import 'package:usainua/repositories/auth_repository.dart';
import 'package:usainua/routes/app_router.dart';
import 'package:usainua/services/google_maps_service.dart';
import 'package:usainua/widgets/button_navigation_bar/custom_bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static const routeName = '/mainPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navigationKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: EarnWithUsPage.routeName,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 25,
        ),
        child: CustomButtonNavigationBar(
          currentIndex: 0,
          onChange: (int index) {
            if (index == 0) {
              navigationKey.currentState?.pushReplacementNamed(
                HomePage.routeName,
              );
            }
            if (index == 1) {
              navigationKey.currentState?.pushReplacementNamed(
                OurChoisePage.routeName,
              );
            }
            if (index == 2) {
              navigationKey.currentState?.pushReplacementNamed(
                MyOrderPage.routeName,
              );
            }
            if (index == 3) {
              navigationKey.currentState?.pushReplacementNamed(
                AccountPage.routeName,
              );
            }
          },
          onFloatingActionButtonPressed: () async {
            // AuthRepository.instance.signOut();
            print('------Regions---------');
            List<Prediction> regionResult =
                await GoogleMapsSerivice.instance.getRegions(
              'Дніп',
            );
            for (Prediction element in regionResult) {
              print(element.description);
            }

            print('--------Cities------------');

            await GoogleMapsSerivice.instance.getCities(
              'Дніп',
            );
            for (Prediction element in regionResult) {
              print(element.description);
            }

            print('----------Streets----------');

            List<Prediction> streetResults =
                await GoogleMapsSerivice.instance.getStreets(
              'Була',
            );
            for (Prediction element in streetResults) {
              print(element.description);
            }
          },
        ),
      ),
    );
  }
}
