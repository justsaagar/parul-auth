import 'package:flutter/material.dart';
import 'package:parul_seminar/app/app_date_formate.dart';
import 'package:parul_seminar/app/app_loader.dart';
import 'package:parul_seminar/app/constant/app_asset.dart';
import 'package:parul_seminar/app/constant/color_constant.dart';
import 'package:parul_seminar/app/string_extensions.dart';
import 'package:parul_seminar/app/ui/app_button.dart';
import 'package:parul_seminar/app/ui/app_image_asset.dart';
import 'package:parul_seminar/app/ui/app_text.dart';
import 'package:parul_seminar/app/ui/app_text_form_field.dart';
import 'package:parul_seminar/screen/sign_in_screen/sign_in_view_model.dart';
import 'package:parul_seminar/screen/sign_up_screen/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  SignInViewModel? signInViewModel;

  @override
  Widget build(BuildContext context) {
    'Current screen --> $runtimeType'.logs();
    signInViewModel = signInViewModel ?? SignInViewModel(this);
    return Scaffold(
      backgroundColor: AppColorConstant.appWhite,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppImageAsset(image: AppAsset.appLogo, height: 50),
                      const SizedBox(height: 50),
                      const AppText('Log In', textAlign: TextAlign.center, fontSize: 20),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: AppTextFormField(
                          controller: signInViewModel?.emailAddressController,
                          errorText: signInViewModel?.emailAddressError,
                          hintText: 'Email Address',
                          prefixIcon: AppAsset.emailIcon,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: AppTextFormField(
                          controller: signInViewModel?.passwordController,
                          errorText: signInViewModel?.passwordError,
                          hintText: 'Password',
                          prefixIcon: AppAsset.lockIcon,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        padding: 18,
                        title: 'Log In',
                        onTap: () => signInViewModel?.validateSignInForm(context),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(right: 18),
                        child: Align(alignment: Alignment.centerRight,child: AppText('Forgot password?')),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen())),
                  child: Container(
                    color: AppColorConstant.appTransparent,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText('Don\'t have an account?'),
                        AppText(' Sign Up', color: AppColorConstant.appPrimaryColor)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (signInViewModel?.isLoading == true) AppLoader(),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 6570)),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      'Formatted date --> ${DateFormatHelper.instance.getPrettyDateFormat(picked) ?? ''}'.logs();
    }
  }
}
