import 'package:flutter/material.dart';
import 'package:parul_seminar/app/constant/color_constant.dart';
import 'package:parul_seminar/app/ui/app_text.dart';

class AppButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final double padding;
  final Color backColor;

  const AppButton({
    super.key,
    required this.title,
    this.padding = 0,
    this.onTap,
    this.backColor = AppColorConstant.appPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(color: backColor, borderRadius: BorderRadius.circular(16)),
        child: AppText(title, color: AppColorConstant.appWhite, fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}
