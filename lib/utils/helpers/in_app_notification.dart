import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_icons.dart';

enum InAppNotificationType {
  info,
  warning,
  error,
  succes,
  cancel,
}

class InAppNotification {
  const InAppNotification._();

  static Color _notificationColor(InAppNotificationType type) {
    if (type == InAppNotificationType.warning) return AppColors.warning;
    if (type == InAppNotificationType.error) return AppColors.error;
    if (type == InAppNotificationType.info) return AppColors.information;
    if (type == InAppNotificationType.cancel) return AppColors.cancel;
    if (type == InAppNotificationType.succes) return AppColors.checked;
    return Colors.white;
  }

  static Color _notificationColorText(InAppNotificationType type) {
    if (type == InAppNotificationType.info) return Colors.black54;
    return Colors.white;
  }

  // static Color _notificationColorIcon(InAppNotificationType type) {
  //   // if (type == InAppNotificationType.info) return AppColors.primary;
  //   return Colors.white;
  // }

  static String _notificationIcon(InAppNotificationType type) {
    if (type == InAppNotificationType.warning) return AppIcons.warning;
    if (type == InAppNotificationType.error) return AppIcons.error;
    if (type == InAppNotificationType.info) return AppIcons.information;
    if (type == InAppNotificationType.cancel) return AppIcons.cancel;
    if (type == InAppNotificationType.succes) return AppIcons.checked;

    return AppIcons.bell;
  }

  static void show({
    required String title,
    required InAppNotificationType type,
  }) {
    BotToast.showCustomNotification(
      align: const Alignment(
        0,
        0.65,
      ),
      onlyOne: true,
      duration: const Duration(
        seconds: 3,
      ),
      animationDuration: const Duration(
        milliseconds: 300,
      ),
      toastBuilder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: _notificationColor(type),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 8.0,
                spreadRadius: 1.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 34.0,
              vertical: 12.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _notificationColorText(type),
                    //color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                SvgPicture.asset(
                  _notificationIcon(type),
                  // color: _notificationColorIcon(type),
                  width: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
