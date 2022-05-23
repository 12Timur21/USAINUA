import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/buttons/nav_link_button.dart';
import 'package:usainua/widgets/text/rich_text_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const routeName = '/accountPage';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppIcons.bell,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppIcons.settings,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _userCard(
                avatar: const AssetImage(
                  AppImages.userAvatar,
                ),
                userName: 'Веленчук Сергій',
                email: 'velenchuk18@gmail.com',
                onClick: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              _balanceCard(
                balanceInDollars: 358.93,
                balanceInHryvnias: 11157,
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              _orderLater(),
              const SizedBox(
                height: 32,
              ),
              _links(),
              const SizedBox(
                height: 70,
              ),
              const RichTextWidgets(
                crossAxisAlignment: CrossAxisAlignment.start,
                textStyle: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.regular,
                  fontSize: AppFonts.sizeXSmall,
                  letterSpacing: 1,
                ),
                children: [
                  Text('Справочник'),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Правила и условия'),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Политика конфиденциальности'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _orderLater() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Хочу заказть позже',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.bold,
              fontSize: AppFonts.sizeSmall,
              letterSpacing: 0.5,
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              'Посмотреть все',
              style: TextStyle(
                color: AppColors.darkBlue,
                fontWeight: AppFonts.regular,
                fontSize: AppFonts.sizeXXSmall,
              ),
            ),
            icon: SvgPicture.asset(
              AppIcons.rightHalfArrow,
            ),
          )
        ],
      ),
      Column(
        children: [
          _cardLater(
            image: Image.asset(
              AppImages.book,
            ),
            url:
                'https://www.ebay.com/itm/Cetyr-roqewqeqewqeqweqweqweqweqwqweqweqweqwe',
            onTap: () {},
          ),
          _cardLater(
            image: Image.asset(
              AppImages.jacket,
            ),
            url:
                'https://www.ebay.com/itm/Cetyr-roasdadasddaqweqweqweqweqweqwesdsadss',
            onTap: () {},
          ),
          _cardLater(
            image: Image.asset(
              AppImages.watch,
            ),
            url:
                'https://www.ebay.com/itm/Cetyr-rozcxqeqweqweqweqweqweqweewqzczxczxczxczczxc',
            onTap: () {},
          ),
        ],
      ),
    ],
  );
}

Widget _links() {
  return RichTextWidgets(
    textStyle: const TextStyle(
      color: AppColors.darkBlue,
      fontWeight: AppFonts.bold,
      fontSize: AppFonts.sizeSmall,
      letterSpacing: 0.5,
    ),
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      NavLinkButton(
        onTap: () {},
        text: 'Финансы',
        icon: SvgPicture.asset(
          AppIcons.wallet,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      NavLinkButton(
        onTap: () {},
        text: 'Банковские карты',
        icon: SvgPicture.asset(
          AppIcons.wallet,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      NavLinkButton(
        onTap: () {},
        text: 'Адреса получателей',
        icon: SvgPicture.asset(
          AppIcons.adress,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      NavLinkButton(
        onTap: () {},
        text: 'Адреса складов',
        icon: SvgPicture.asset(
          AppIcons.adressHouse,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      NavLinkButton(
        onTap: () {},
        text: 'Зарабатывайте c нами',
        icon: SvgPicture.asset(
          AppIcons.graph,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      NavLinkButton(
        onTap: () {},
        text: 'Новости',
        icon: SvgPicture.asset(
          AppIcons.news,
        ),
      ),
    ],
  );
}

Widget _cardLater({
  required Image image,
  required String url,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: image,
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              url,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.darkBlue.withOpacity(0.5),
                letterSpacing: 1,
                fontSize: AppFonts.sizeXSmall,
                fontWeight: AppFonts.regular,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _userCard({
  required ImageProvider avatar,
  required String userName,
  required String email,
  required VoidCallback onClick,
}) {
  return Container(
    height: 75,
    decoration: const BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.all(
        Radius.circular(42),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.red,
            backgroundImage: avatar,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.heavy,
                  letterSpacing: 0.5,
                  fontSize: AppFonts.sizeLarge,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.regular,
                  fontSize: AppFonts.sizeXSmall,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onClick,
            icon: SvgPicture.asset(
              AppIcons.editBox,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _balanceCard({
  required double balanceInDollars,
  required double balanceInHryvnias,
  required VoidCallback onTap,
}) {
  return Container(
    height: 75,
    decoration: const BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Баланс',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeSmall,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$balanceInDollars \$',
                      style: const TextStyle(
                        color: AppColors.lightGreen,
                        fontWeight: AppFonts.bold,
                        fontSize: AppFonts.sizeSmall,
                      ),
                    ),
                    TextSpan(
                      text: ' \\ $balanceInHryvnias грн',
                      style: const TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: AppFonts.regular,
                        fontSize: AppFonts.sizeXSmall,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(left: 20),
              child: TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Пополнить',
                  style: TextStyle(
                    color: AppColors.darkGreen,
                    fontWeight: AppFonts.bold,
                    fontSize: AppFonts.sizeXSmall,
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
