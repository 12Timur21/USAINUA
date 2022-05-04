import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/pages/main_pages/widgets/custom_bottom_navigation_bar.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            AppIcons.bell,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: SvgPicture.asset(
          AppIcons.logo,
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppIcons.dialog,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {},
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                shape: BoxShape.circle,
                color: AppColors.buttonPrimary,
              ),
              child: SvgPicture.asset(
                AppIcons.plus,

                fit: BoxFit.scaleDown,
                // width: 24,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomButtonNavigationBar(
        currentIndex: 0,
        onChange: (int index) {},
      ),
      body: Container(),
    );
  }
}
