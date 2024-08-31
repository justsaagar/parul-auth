import 'package:flutter/material.dart';
import 'package:parul_seminar/app/constant/app_asset.dart';
import 'package:parul_seminar/app/constant/color_constant.dart';
import 'package:parul_seminar/app/ui/app_image_asset.dart';
import 'package:parul_seminar/app/ui/app_text.dart';

class AppDropdown extends StatelessWidget {
  final String hintText;
  final String? selectedGender;
  final ValueChanged<String?>? onChanged;

  const AppDropdown({super.key, required this.hintText, this.selectedGender, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: AppAsset.publicSansFont, color: AppColorConstant.appGrey),
          contentPadding: const EdgeInsets.only(bottom: 0, left: 16, right: 16),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AppImageAsset(image: AppAsset.personIcon, height: 16, width: 16),
          ),
          filled: true,
          fillColor: AppColorConstant.appWhite800,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        value: selectedGender,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        iconSize: 24,
        style: const TextStyle(color: Colors.black),
        items: <String>['Male', 'Female', 'Other'].map((String value) => DropdownMenuItem<String>(value: value, child: AppText(value))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
