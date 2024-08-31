import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parul_seminar/app/app_date_formate.dart';
import 'package:parul_seminar/app/string_extensions.dart';
import 'package:parul_seminar/app/validation_helper.dart';
import 'package:parul_seminar/screen/profile_screen/profile_screen.dart';
import 'package:parul_seminar/screen/sign_in_screen/sign_in_screen.dart';
import 'package:parul_seminar/screen/sign_up_screen/sign_up_screen.dart';
import 'package:parul_seminar/service/authentication_service.dart';

class SignInViewModel {
  final SignInScreenState signInScreenState;
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailAddressError = '';
  String passwordError = '';
  bool isLoading = false;

  SignInViewModel(this.signInScreenState);

  Future<void> validateSignInForm(BuildContext context) async {
    if (ValidationHelper.instance.validateEmptyController(emailAddressController)) {
      emailAddressError = 'Please enter email address';
    } else if (ValidationHelper.instance.regexValidator(emailAddressController, ValidationHelper.emailRegexp)) {
      emailAddressError = 'Please enter valid email';
    } else {
      emailAddressError = '';
    }
    if (ValidationHelper.instance.validateEmptyController(passwordController)) {
      passwordError = 'Please enter password';
    }else {
      passwordError = '';
    }
    signInScreenState.setState(() {});
    if (emailAddressError.isEmpty && passwordError.isEmpty) {
      await verifyUser(context);
    }
  }

  Future<void> verifyUser(BuildContext context) async {
    isLoading = true;
    FocusScope.of(context).unfocus();
    signInScreenState.setState(() {});
    User? validateUser = await AuthenticationService.instance.verifyUserWithEmailPassword(
      emailAddressController.text,
      passwordController.text,
      context,
    );
    if (validateUser != null) {
      'Login successfully'.showToast(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }
    isLoading = false;
    signInScreenState.setState(() {});
  }
}
