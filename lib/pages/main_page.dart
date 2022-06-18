import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usainua/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:usainua/pages/main_pages/account_pages/account_page/account_page.dart';
import 'package:usainua/pages/main_pages/home_pages/home_page/home_page.dart';
import 'package:usainua/pages/main_pages/my_order_pages/my_order_page/my_order_page.dart';
import 'package:usainua/pages/main_pages/my_order_pages/order_view_page/order_view_page.dart';

import 'package:usainua/pages/main_pages/order_pages/our_choise_page/out_choice_page.dart';
import 'package:usainua/resources/app_colors.dart';

import 'package:usainua/routes/app_router.dart';
import 'package:usainua/widgets/button_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:usainua/widgets/custom_bottom_sheet/custom_bottom_sheet.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static const routeName = '/mainPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BuildContext? _bottomSheetContext;
  int _currentIndex = 0;

  void _changeBottomSheetStatus(bool isOpened) {
    final NavigationBloc navigationBloc = context.read<NavigationBloc>();
    navigationBloc.add(
      ChangeOrderBottomNavigationSheetBarStatus(
        showBottomSheet: isOpened,
      ),
    );
  }

  void _onActionButtonPressed() {
    final NavigationState navigationState =
        context.read<NavigationBloc>().state;

    if (navigationState.showBottomSheet && _bottomSheetContext != null) {
      Navigator.pop(_bottomSheetContext!);
    } else {
      _changeBottomSheetStatus(true);

      showModalBottomSheet(
        context: MainPage.navigationKey.currentContext!,
        backgroundColor: Colors.white,
        barrierColor: AppColors.primary.withOpacity(
          0.85,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          _bottomSheetContext = context;
          return const CustomButtomSheet();
        },
      ).whenComplete(() {
        _bottomSheetContext = null;
        _changeBottomSheetStatus(false);
      });
    }
  }

  void _onIndexChanged(int index) {
    final NavigationBloc navigationBloc = context.read<NavigationBloc>();

    if (navigationBloc.state.showBottomSheet && _bottomSheetContext != null) {
      Navigator.pop(_bottomSheetContext!);
      _changeBottomSheetStatus(false);
    }

    if (_currentIndex != index) {
      if (index == 0) {
        MainPage.navigationKey.currentState?.pushReplacementNamed(
          HomePage.routeName,
          // PurchaseAndDeliveryPage.routeName,
        );
      }
      if (index == 1) {
        MainPage.navigationKey.currentState?.pushReplacementNamed(
          OurChoisePage.routeName,
        );
      }
      if (index == 2) {
        MainPage.navigationKey.currentState?.pushReplacementNamed(
          MyOrderPage.routeName,
        );
      }
      if (index == 3) {
        MainPage.navigationKey.currentState?.pushReplacementNamed(
          AccountPage.routeName,
        );
      }

      navigationBloc.add(
        NavigateToIndex(
          index: index,
        ),
      );

      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: MainPage.navigationKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: HomePage.routeName,
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state.showBottomNavBar) {
            return CustomButtonNavigationBar(
              onActiveButtonPressed: _onActionButtonPressed,
              onIndexChanged: _onIndexChanged,
            );
          }
          return Container(
            height: 0,
          );
        },
      ),
    );
  }
}
