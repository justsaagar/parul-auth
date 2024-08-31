import 'package:flutter/material.dart';
import 'package:parul_seminar/app/app_date_formate.dart';
import 'package:parul_seminar/app/app_loader.dart';
import 'package:parul_seminar/app/constant/color_constant.dart';
import 'package:parul_seminar/app/string_extensions.dart';
import 'package:parul_seminar/app/ui/app_text.dart';
import 'package:parul_seminar/app/ui/app_text_form_field.dart';
import 'package:parul_seminar/service/authentication_service.dart';

import 'profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel? profileViewModel;

  @override
  Widget build(BuildContext context) {
    'Current screen --> $runtimeType'.logs();
    profileViewModel = profileViewModel ?? ProfileViewModel(this);
    return Scaffold(
      backgroundColor: AppColorConstant.appWhite,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: [
                const SizedBox(height: 50),
                const AppText('User Profile', textAlign: TextAlign.center, fontSize: 20),
                const SizedBox(height: 16),
                AppTextFormField(controller: profileViewModel?.firstNameController, hintText: 'First Name', showHeader: true),
                const SizedBox(height: 16),
                AppTextFormField(controller: profileViewModel?.lastNameController, hintText: 'Last Name', showHeader: true),
                const SizedBox(height: 16),
                AppTextFormField(controller: profileViewModel?.emailAddressController, hintText: 'Email Address', showHeader: true),
                const SizedBox(height: 16),
                AppTextFormField(controller: profileViewModel?.dateOfBirthController, hintText: 'Date Of Birth', showHeader: true),
                const SizedBox(height: 16),
                AppTextFormField(controller: profileViewModel?.genderController, hintText: 'Gender', showHeader: true),
              ],
            ),
            if (profileViewModel?.isLoading ?? false) const AppLoader(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColorConstant.appPrimaryColor,
        onPressed: () => AuthenticationService.instance.signOut(context),
        child: const Icon(Icons.logout_rounded, color: AppColorConstant.appWhite),
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
