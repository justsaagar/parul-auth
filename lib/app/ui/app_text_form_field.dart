import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parul_seminar/app/constant/app_asset.dart';
import 'package:parul_seminar/app/constant/color_constant.dart';
import 'package:parul_seminar/app/ui/app_image_asset.dart';
import 'package:parul_seminar/app/ui/app_text.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final BoxBorder? border;
  final String? hintText;
  final bool obscureText;
  final String? fontFamily;
  final String? prefixIcon;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool readOnly;
  final bool showHeader;
  final GestureTapCallback? onTap;

  const AppTextFormField({
    required this.controller,
    super.key,
    this.hintText,
    this.border,
    this.obscureText = false,
    this.fontFamily = AppAsset.publicSansFont,
    this.prefixIcon,
    this.inputFormatters,
    this.keyboardType,
    this.errorText,
    this.maxLines,
    this.onTap,
    this.readOnly = false,
    this.showHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader) ... [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: AppText(hintText ?? '', fontSize: 14, color: AppColorConstant.appGrey),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColorConstant.appWhite800,
          ),
          child: Row(
            children: [
              if (prefixIcon != null) ... [
                const SizedBox(width: 16),
                AppImageAsset(image: prefixIcon ?? AppAsset.personIcon, height: 16, width: 16),
              ],
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  readOnly: readOnly,
                  inputFormatters: inputFormatters,
                  keyboardType: keyboardType,
                  maxLines: maxLines,
                  onTap: onTap,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: const TextStyle(fontFamily: AppAsset.publicSansFont, color: AppColorConstant.appGrey),
                    contentPadding: const EdgeInsets.only(top: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null && (errorText?.isNotEmpty ?? false)) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: AppText(
              errorText ?? '',
              color: AppColorConstant.appErrorColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: fontFamily,
            ),
          ),
        ],
      ],
    );
  }
}
