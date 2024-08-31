import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parul_seminar/app/constant/color_constant.dart';
import 'package:parul_seminar/app/ui/app_text.dart';

extension StringExtensions on String {
  void logs() {
    if (kDebugMode) {
      print(this);
    }
  }

  void showToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AppText(this, color: AppColorConstant.appWhite)));
  }
}
