import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/models/payment_card_model.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/utils/constants.dart';

class CardUtils {
  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Это обязательное поле';
    }

    //TODO WTF
    if (value.length < 3 || value.length > 4) {
      return "CVV недейсивительно";
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Это обязательное поле';
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(RegExp(r'(/)'))) {
      List<String> split = value.split(RegExp(r'(/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Неверный месяц';
    }

    int fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Неверный год';
    }

    if (!hasDateExpired(month, year)) {
      return "Срок действия истёк";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      DateTime now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    List<String> split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    DateTime now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    DateTime now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static SvgPicture getCardIcon({
    required PaymentCardType? paymentCardType,
    BoxFit boxFit = BoxFit.contain,
  }) {
    String iconUrl;

    switch (paymentCardType) {
      case PaymentCardType.masterCard:
        iconUrl = AppIcons.masterCard;
        break;
      case PaymentCardType.visa:
        iconUrl = AppIcons.visa;
        break;
      case PaymentCardType.verve:
        iconUrl = AppIcons.verve;
        break;
      case PaymentCardType.americanExpress:
        iconUrl = AppIcons.americanExpress;
        break;
      case PaymentCardType.discover:
        iconUrl = AppIcons.discoverCard;
        break;
      case PaymentCardType.dinersClub:
        iconUrl = AppIcons.dinersClub;
        break;
      case PaymentCardType.jcb:
        iconUrl = AppIcons.jcb;
        break;

      default:
        iconUrl = AppIcons.creditCard;
        break;
    }

    return SvgPicture.asset(
      iconUrl,
      fit: boxFit,
    );
  }

  /// With the card number with Luhn Algorithm
  /// https://en.wikipedia.org/wiki/Luhn_algorithm
  static String? validateCardNumWithLuhnAlgorithm(String? input) {
    if (input == null || input.isEmpty) {
      return 'Это обязательное поле';
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      return 'Карта недействительна';
    }

    int sum = 0;
    int length = input.length;
    for (int i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return 'Карта недействительна';
  }

  static PaymentCardType getPaymentCardTypeFromNumber(String input) {
    PaymentCardType paymentCardType;
    if (input.startsWith(
      RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))',
      ),
    )) {
      paymentCardType = PaymentCardType.masterCard;
    } else if (input.startsWith(
      RegExp(
        r'[4]',
      ),
    )) {
      paymentCardType = PaymentCardType.visa;
    } else if (input.startsWith(
      RegExp(
        r'((506(0|1))|(507(8|9))|(6500))',
      ),
    )) {
      paymentCardType = PaymentCardType.verve;
    } else if (input.startsWith(
      RegExp(
        r'((34)|(37))',
      ),
    )) {
      paymentCardType = PaymentCardType.americanExpress;
    } else if (input.startsWith(
      RegExp(
        r'((6[45])|(6011))',
      ),
    )) {
      paymentCardType = PaymentCardType.discover;
    } else if (input.startsWith(
      RegExp(
        r'((30[0-5])|(3[89])|(36)|(3095))',
      ),
    )) {
      paymentCardType = PaymentCardType.dinersClub;
    } else if (input.startsWith(
      RegExp(
        r'(352[89]|35[3-8][0-9])',
      ),
    )) {
      paymentCardType = PaymentCardType.jcb;
    } else if (input.length <= 8) {
      paymentCardType = PaymentCardType.others;
    } else {
      paymentCardType = PaymentCardType.invalid;
    }
    return paymentCardType;
  }
}
