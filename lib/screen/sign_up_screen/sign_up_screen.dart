import 'package:flutter/material.dart';
import 'package:parul_seminar/app/app_date_formate.dart';
import 'package:parul_seminar/app/app_loader.dart';
import 'package:parul_seminar/app/constant/app_asset.dart';
import 'package:parul_seminar/app/constant/color_constant.dart';
import 'package:parul_seminar/app/string_extensions.dart';
import 'package:parul_seminar/app/ui/app_button.dart';
import 'package:parul_seminar/app/ui/app_dropdown.dart';
import 'package:parul_seminar/app/ui/app_text.dart';
import 'package:parul_seminar/app/ui/app_text_form_field.dart';
import 'package:parul_seminar/screen/sign_in_screen/sign_in_screen.dart';
import 'package:parul_seminar/screen/sign_up_screen/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel? signUpViewModel;

  @override
  Widget build(BuildContext context) {
    'Current screen --> $runtimeType'.logs();
    signUpViewModel ?? (signUpViewModel = SignUpViewModel(this));
    return Scaffold(
      backgroundColor: AppColorConstant.appWhite,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    children: [
                      const AppText('Sign Up', textAlign: TextAlign.center, fontSize: 20),
                      const SizedBox(height: 16),
                      AppTextFormField(
                        controller: signUpViewModel?.firstNameController,
                        errorText: signUpViewModel?.firstNameError,
                        hintText: 'First Name',
                        prefixIcon: AppAsset.personIcon,
                      ),
                      const SizedBox(height: 16),
                      AppTextFormField(
                        controller: signUpViewModel?.lastNameController,
                        errorText: signUpViewModel?.lastNameError,
                        hintText: 'Last Name',
                        prefixIcon: AppAsset.personIcon,
                      ),
                      const SizedBox(height: 16),
                      AppTextFormField(
                        controller: signUpViewModel?.emailAddressController,
                        errorText: signUpViewModel?.emailAddressError,
                        hintText: 'Email Address',
                        prefixIcon: AppAsset.emailIcon,
                      ),
                      const SizedBox(height: 16),
                      AppTextFormField(
                        controller: signUpViewModel?.dateOfBirthController,
                        errorText: signUpViewModel?.dateOfBirthError,
                        hintText: 'Date Of Birth',
                        prefixIcon: AppAsset.calendarIcon,
                        readOnly: true,
                        onTap: () => signUpViewModel?.selectDate(context),
                      ),
                      const SizedBox(height: 16),
                      AppDropdown(
                        hintText: 'Select Gender',
                        selectedGender: signUpViewModel?.selectedGender,
                        onChanged: (value) => signUpViewModel?.updateSelectedGender(value),
                      ),
                      const SizedBox(height: 16),
                      AppTextFormField(
                        controller: signUpViewModel?.passwordController,
                        errorText: signUpViewModel?.passwordError,
                        hintText: 'Password',
                        prefixIcon: AppAsset.lockIcon,
                      ),
                      const SizedBox(height: 16),
                      AppTextFormField(
                        controller: signUpViewModel?.confirmPasswordController,
                        errorText: signUpViewModel?.confirmPasswordError,
                        hintText: 'Confirm Password',
                        prefixIcon: AppAsset.lockIcon,
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        title: 'Sign up',
                        onTap: () => signUpViewModel?.validateSignUpForm(context),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen())),
                  child: Container(
                    color: AppColorConstant.appTransparent,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [AppText('Already a User?'), AppText(' Sign In', color: AppColorConstant.appPrimaryColor)],
                    ),
                  ),
                ),
              ],
            ),
            if (signUpViewModel?.isLoading == true) const AppLoader(),
          ],
        ),
      ),
    );
  }
}
