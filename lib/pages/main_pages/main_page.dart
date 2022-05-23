import 'package:flutter/material.dart';
import 'package:usainua/pages/main_pages/account_pages/account_page/account_page.dart';
import 'package:usainua/pages/main_pages/account_pages/personal_data_page/personal_data_page.dart';
import 'package:usainua/pages/main_pages/home_page/home_page.dart';
import 'package:usainua/repositories/auth_repository.dart';
import 'package:usainua/routes/app_router.dart';
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
        initialRoute: HomePage.routeName,
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
              // navigationKey.currentState?.pushReplacementNamed(
              //   HomePage.routeName,
              // );
            }
            if (index == 2) {
              // navigationKey.currentState?.pushReplacementNamed(
              //   HomePage.routeName,
              // );
            }
            if (index == 3) {
              navigationKey.currentState?.pushReplacementNamed(
                AccountPage.routeName,
              );
            }
          },
          onFloatingActionButtonPressed: () {
            AuthRepository.instance.signOut();
          },
        ),
      ),
    );
  }
}
