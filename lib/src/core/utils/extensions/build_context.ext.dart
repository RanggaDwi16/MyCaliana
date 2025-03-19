import 'package:flutter/material.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';

extension BuildContextExt on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;

  double get deviceWidth => MediaQuery.of(this).size.width;

  void showCustomSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: AppColor.blackColor),
        ),
        backgroundColor: isError ? Colors.redAccent : AppColor.whiteColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
