import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parul_seminar/app/app_date_formate.dart';
import 'package:parul_seminar/app/string_extensions.dart';
import 'package:parul_seminar/app/validation_helper.dart';
import 'package:parul_seminar/screen/profile_screen/profile_screen.dart';
import 'package:parul_seminar/screen/sign_up_screen/sign_up_screen.dart';
import 'package:parul_seminar/service/authentication_service.dart';
import 'package:parul_seminar/service/users_service.dart';
import 'package:parul_seminar/user_model.dart';

class SignUpViewModel {
  final SignUpScreenState signUpScreenState;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String firstNameError = '';
  String lastNameError = '';
  String emailAddressError = '';
  String dateOfBirthError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String? selectedGender;
  bool isLoading = false;

  SignUpViewModel(this.signUpScreenState);

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 6570)),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.text = DateFormatHelper.instance.getPrettyDateFormat(picked) ?? '';
      'Formatted date --> ${dateOfBirthController.text}'.logs();
    }
  }

  void updateSelectedGender(String? value) {
    selectedGender = value;
    signUpScreenState.setState(() {});
  }

  Future<void> validateSignUpForm(BuildContext context) async {
    if (ValidationHelper.instance.validateEmptyController(firstNameController)) {
      firstNameError = 'Please enter first name';
    } else if (ValidationHelper.instance.regexValidator(firstNameController, ValidationHelper.nameRegExp)) {
      firstNameError = 'Please enter valid name';
    } else {
      firstNameError = '';
    }
    if (ValidationHelper.instance.validateEmptyController(lastNameController)) {
      lastNameError = 'Please enter last name';
    } else if (ValidationHelper.instance.regexValidator(lastNameController, ValidationHelper.nameRegExp)) {
      lastNameError = 'Please enter valid name';
    } else {
      lastNameError = '';
    }
    if (ValidationHelper.instance.validateEmptyController(emailAddressController)) {
      emailAddressError = 'Please enter email address';
    } else if (ValidationHelper.instance.regexValidator(emailAddressController, ValidationHelper.emailRegexp)) {
      emailAddressError = 'Please enter valid email';
    } else {
      emailAddressError = '';
    }
    if (ValidationHelper.instance.validateEmptyController(dateOfBirthController)) {
      dateOfBirthError = 'Please enter date of birth';
    } else {
      dateOfBirthError = '';
    }
    if (ValidationHelper.instance.validateEmptyController(passwordController)) {
      passwordError = 'Please enter password';
    } else if (ValidationHelper.instance.regexValidator(passwordController, ValidationHelper.passwordRegexp)) {
      passwordError = 'please enter valid password';
    } else {
      passwordError = '';
    }
    if (ValidationHelper.instance.validateEmptyController(confirmPasswordController)) {
      confirmPasswordError = 'Please enter confirm password';
    } else if (ValidationHelper.instance.regexValidator(confirmPasswordController, ValidationHelper.passwordRegexp)) {
      confirmPasswordError = 'Please enter valid confirm password';
    } else if (ValidationHelper.instance.compareValidator(confirmPasswordController, passwordController)) {
      confirmPasswordError = 'Password - confirm password not matching';
    } else {
      confirmPasswordError = '';
    }
    signUpScreenState.setState(() {});
    if (firstNameError.isEmpty && lastNameError.isEmpty && emailAddressError.isEmpty && dateOfBirthError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty) {
      await createUser(context);
    }
  }

  Future<void> createUser(BuildContext context) async {
    isLoading = true;
    FocusScope.of(context).unfocus();
    signUpScreenState.setState(() {});
    User? validateUser = await AuthenticationService.instance.createUserWithEmailPassword(
      emailAddressController.text,
      passwordController.text,
      context,
    );
    if (validateUser != null) {
      UserModel userModel = UserModel(
        userId: validateUser.uid,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        emailAddress: emailAddressController.text,
        dateOfBirth: dateOfBirthController.text,
        gender: selectedGender ?? '',
      );
      await UserService.instance.createUser(userModel, context);
      'User created successfully'.showToast(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }
    isLoading = false;
    signUpScreenState.setState(() {});
  }
}
