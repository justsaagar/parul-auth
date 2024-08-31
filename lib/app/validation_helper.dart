import 'package:flutter/material.dart';

class ValidationHelper {
  ValidationHelper._privateConstructor();

  static final ValidationHelper instance = ValidationHelper._privateConstructor();

  //     ======================= Regular Expressions =======================     //
  static const String nameRegExp = r'^[a-zA-Z]+$';
  static const String emailRegexp = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String passwordRegexp = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

  //     ======================= Validation methods =======================     //
  bool validateEmptyController(TextEditingController textEditingController) {
    return textEditingController.text.trim().isEmpty;
  }

  bool lengthValidator(TextEditingController textEditingController, int length) {
    return textEditingController.text.trim().length < length;
  }

  bool regexValidator(TextEditingController textEditingController, String regex) {
    return !RegExp(regex).hasMatch(textEditingController.text.trim());
  }

  bool compareValidator(TextEditingController textEditingController, TextEditingController secondController) {
    return textEditingController.text != secondController.text;
  }
}
