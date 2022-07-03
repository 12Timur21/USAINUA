import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/blocs/authorization_bloc/authorization_bloc.dart';
import 'package:usainua/models/user_model.dart';
import 'package:usainua/pages/main_pages/account_pages/all_credit_cards_page/all_credit_cards_page.dart';
import 'package:usainua/pages/main_pages/account_pages/earn_with_us_page/earn_with_us_page.dart';
import 'package:usainua/pages/main_pages/account_pages/finance_page/finance_page.dart';
import 'package:usainua/pages/main_pages/account_pages/personal_data_page/personal_data_page.dart';
import 'package:usainua/pages/main_pages/account_pages/recipient_addresses_page/recipient_addresses_page.dart';
import 'package:usainua/pages/main_pages/account_pages/warehouse_adresses_page/warehouse_adresses_page.dart';
import 'package:usainua/pages/privacy_terms_page/privacy_terms_page.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/text/rich_text_wrapper.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const routeName = '/accountPage';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final UserModel _userModel;

  @override
  void initState() {
    _userModel = context.read<AuthorizationBloc>().state.userModel!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: const SizedBox(),
        actionIcon: SvgPicture.asset(
          AppIcons.settings,
        ),
        text: 'Банковские карты',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserCard(
                avatar: const AssetImage(
                  AppImages.userAvatar,
                ),
                userName: _userModel.name!,
                email: _userModel.email!,
                onClick: () {
                  Navigator.of(context).pushNamed(
                    PersonalDataPage.routeName,
                  );
                },
              ),
              const SizedBox(height: 20),
              _BalanceCard(
                balanceInDollars: 358.93,
                balanceInHryvnias: 11157,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const _OrderLater(),
              const SizedBox(height: 32),
              const _Links(),
              const SizedBox(height: 30),
              const _AdditionalInformation(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({
    required this.balanceInDollars,
    required this.balanceInHryvnias,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final double balanceInDollars;
  final double balanceInHryvnias;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                child: SubmitButton(
                  onTap: onTap,
                  text: 'Пополнить',
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({
    required this.avatar,
    required this.userName,
    required this.email,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  final ImageProvider avatar;
  final String userName;
  final String email;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
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
}

//TODO вынести и реализовать логику
class _OrderLater extends StatelessWidget {
  const _OrderLater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            _CardLater(
              image: Image.asset(
                AppImages.book,
              ),
              url:
                  'https://www.ebay.com/itm/Cetyr-roqewqeqewqeqweqweqweqweqwqweqweqweqwe',
              onTap: () {},
            ),
            _CardLater(
              image: Image.asset(
                AppImages.jacket,
              ),
              url:
                  'https://www.ebay.com/itm/Cetyr-roasdadasddaqweqweqweqweqweqwesdsadss',
              onTap: () {},
            ),
            _CardLater(
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
}

class _CardLater extends StatelessWidget {
  const _CardLater({
    required this.image,
    required this.url,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Image image;
  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
}

class _Links extends StatelessWidget {
  const _Links({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichTextWrapper(
      textStyle: const TextStyle(
        color: AppColors.darkBlue,
        fontWeight: AppFonts.bold,
        fontSize: AppFonts.sizeSmall,
        letterSpacing: 0.5,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconTextButton(
          onTap: () {
            Navigator.of(context).pushNamed(
              FinancePage.routeName,
            );
          },
          text: 'Финансы',
          icon: SvgPicture.asset(
            AppIcons.wallet,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        IconTextButton(
          onTap: () {
            Navigator.of(context).pushNamed(
              AllCreditCardsPage.routeName,
            );
          },
          text: 'Банковские карты',
          icon: SvgPicture.asset(
            AppIcons.creditCard,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        IconTextButton(
          onTap: () {
            Navigator.of(context).pushNamed(
              RecipientAddressesPage.routeName,
            );
          },
          text: 'Адреса получателей',
          icon: SvgPicture.asset(
            AppIcons.adress,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        IconTextButton(
          onTap: () {
            Navigator.of(context).pushNamed(
              WarehouseAdressesPage.routeName,
            );
          },
          text: 'Адреса складов',
          icon: SvgPicture.asset(
            AppIcons.adressHouse,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        IconTextButton(
          onTap: () {
            Navigator.of(context).pushNamed(
              EarnWithUsPage.routeName,
            );
          },
          text: 'Зарабатывайте c нами',
          icon: SvgPicture.asset(
            AppIcons.graph,
          ),
        ),
      ],
    );
  }
}

class _AdditionalInformation extends StatelessWidget {
  const _AdditionalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              PrivacyTermsPage.routeName,
              arguments: 'terms_and_conditions.md',
            );
          },
          child: const Text(
            'Правила и условия',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.regular,
              fontSize: AppFonts.sizeXSmall,
              letterSpacing: 1,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              PrivacyTermsPage.routeName,
              arguments: 'privacy_policy.md',
            );
          },
          child: const Text(
            'Политика конфиденциальности',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.regular,
              fontSize: AppFonts.sizeXSmall,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
