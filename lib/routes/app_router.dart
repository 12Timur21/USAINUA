import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:usainua/pages/auth_pages/additional_data_collection_page/additional_data_collection_page.dart';
import 'package:usainua/pages/auth_pages/credential_linking_page/credential_linking_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/intro_slider_page/intro_slider_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/statistics_page/statistics_page.dart';
import 'package:usainua/pages/auth_pages/introduction_pages/welcome_page/welcome_page.dart';
import 'package:usainua/pages/auth_pages/sign_in_page/sign_in_page.dart';
import 'package:usainua/pages/auth_pages/sign_up_page/sign_up_page.dart';
import 'package:usainua/pages/auth_pages/verification_code_page/verification_code_page.dart';
import 'package:usainua/pages/main_page.dart';
import 'package:usainua/pages/main_pages/account_pages/account_page/account_page.dart';
import 'package:usainua/pages/main_pages/account_pages/add_new_card_page/add_new_card_page.dart';
import 'package:usainua/pages/main_pages/account_pages/add_recipient_addresses_page/add_recipient_addresses_page.dart';
import 'package:usainua/pages/main_pages/account_pages/all_credit_cards_page/all_credit_cards_page.dart';
import 'package:usainua/pages/main_pages/account_pages/earn_with_us_page/earn_with_us_page.dart';
import 'package:usainua/pages/main_pages/account_pages/finance_page/finance_page.dart';
import 'package:usainua/pages/main_pages/account_pages/personal_data_page/personal_data_page.dart';
import 'package:usainua/pages/main_pages/account_pages/recipient_addresses_page/recipient_addresses_page.dart';
import 'package:usainua/pages/main_pages/account_pages/warehouse_adresses_page/warehouse_adresses_page.dart';
import 'package:usainua/pages/main_pages/home_pages/home_page/home_page.dart';
import 'package:usainua/pages/main_pages/home_pages/only_delivery_infromation_page/only_delivery_infromation_page.dart';
import 'package:usainua/pages/main_pages/home_pages/purchase_and_delivery_infromation_page/purchase_and_delivery_infromation_page.dart';
import 'package:usainua/pages/main_pages/home_pages/tariff_page/tariff_page.dart';
import 'package:usainua/pages/main_pages/my_order_pages/my_order_page/my_order_page.dart';
import 'package:usainua/pages/main_pages/my_order_pages/order_view_page/order_view_page.dart';
import 'package:usainua/pages/main_pages/order_pages/approximate_cost_purchase_and_delivery_page/approximate_cost_purchase_and_delivery_page.dart';
import 'package:usainua/pages/main_pages/order_pages/only_delivery_page/only_delivery_page.dart';
import 'package:usainua/pages/main_pages/order_pages/our_choise_page/out_choice_page.dart';
import 'package:usainua/pages/main_pages/order_pages/purchase_and_delivery_page/purchase_and_delivery_page.dart';

import 'package:usainua/pages/privacy_terms_page/privacy_terms_page.dart';
import 'package:usainua/pages/splash_screen_page/splash_screen_page.dart';
import 'package:usainua/utils/constants.dart';

class AppRouter {
  const AppRouter._();

  static PageTransition generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    Widget builder;

    switch (settings.name) {
      case SplashScreenPage.routeName:
        builder = const SplashScreenPage();
        break;

      case PrivacyTermsPage.routeName:
        String? mdFileName = arguments as String?;
        builder = PrivacyTermsPage(
          mdFileName: mdFileName!,
        );
        break;

      //? [START] Auth pages
      case SignInPage.routeName:
        builder = const SignInPage();
        break;

      case SignUpPage.routeName:
        builder = const SignUpPage();
        break;

      case CredentialLinkingPage.routeName:
        CredentialLinkingPageParameters parameters =
            arguments as CredentialLinkingPageParameters;
        builder = CredentialLinkingPage(
          parameters: parameters,
        );
        break;

      case VerificationCodePage.routeName:
        VerificationCodePageParameters parameters =
            arguments as VerificationCodePageParameters;
        builder = VerificationCodePage(
          parameters: parameters,
        );
        break;

      case AdditionalDataCollectionPage.routeName:
        AdditionalDataCollectionPageParameters pageParameters =
            arguments as AdditionalDataCollectionPageParameters;
        builder = AdditionalDataCollectionPage(
          parameters: pageParameters,
        );
        break;

      //? [END] Auth pages

      //? [START] Intro page
      case WelcomePage.routeName:
        builder = const WelcomePage();
        break;

      case IntroSliderPage.routeName:
        builder = const IntroSliderPage();
        break;

      case StatisticsPage.routeName:
        builder = const StatisticsPage();
        break;
      //? [END] Intro page

      //? [START] Main pages
      case MainPage.routeName:
        builder = const MainPage();
        break;

      case HomePage.routeName:
        builder = const HomePage();
        break;

      case PurchaseAndDeliveryInfromationPage.routeName:
        builder = const PurchaseAndDeliveryInfromationPage();
        break;

      case OnlyDeliveryInfromationPage.routeName:
        builder = const OnlyDeliveryInfromationPage();
        break;

      case TariffPage.routeName:
        DispatchType? dispatchType = arguments as DispatchType?;
        builder = TariffPage(
          initDispatchType: dispatchType,
        );
        break;
      //? [END] Main pages

      //? [START] Account pages
      case AccountPage.routeName:
        builder = const AccountPage();
        break;

      case PersonalDataPage.routeName:
        builder = const PersonalDataPage();
        break;

      case FinancePage.routeName:
        builder = const FinancePage();
        break;

      case AllCreditCardsPage.routeName:
        builder = const AllCreditCardsPage();
        break;

      case AddNewCardPage.routeName:
        builder = const AddNewCardPage();
        break;

      case AddRecipientAddressesPage.routeName:
        builder = const AddRecipientAddressesPage();
        break;

      case RecipientAddressesPage.routeName:
        builder = const RecipientAddressesPage();
        break;

      case WarehouseAdressesPage.routeName:
        builder = const WarehouseAdressesPage();
        break;
      case EarnWithUsPage.routeName:
        builder = const EarnWithUsPage();
        break;
      //? [END] Account pages

      //? [START] Our choise pages
      case OurChoisePage.routeName:
        builder = const OurChoisePage();
        break;

      case PurchaseAndDeliveryPage.routeName:
        builder = const PurchaseAndDeliveryPage();
        break;

      case ApproximateCostPurchaseAndDeliveryPage.routeName:
        builder = const ApproximateCostPurchaseAndDeliveryPage();
        break;

      case OnlyDeliveryPage.routeName:
        builder = const OnlyDeliveryPage();
        break;
      //? [END] Account pages

      //? [START] My order pages
      case MyOrderPage.routeName:
        builder = const MyOrderPage();
        break;

      case OrderViewPage.routeName:
        builder = const OrderViewPage();
        break;
      //? [END] My order pages

      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return PageTransition(
      child: builder,
      settings: settings,
      type: PageTransitionType.rightToLeft,
    );
  }
}
