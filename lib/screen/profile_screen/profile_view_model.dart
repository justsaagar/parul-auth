import 'package:flutter/material.dart';
import 'package:parul_seminar/screen/profile_screen/profile_screen.dart';
import 'package:parul_seminar/service/users_service.dart';
import 'package:parul_seminar/user_model.dart';

class ProfileViewModel {
  ProfileScreenState profileScreenState;
  UserModel? userModel;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  bool isLoading = true;

  ProfileViewModel(this.profileScreenState) {
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    userModel = await UserService.instance.getCurrentDataUser(profileScreenState.context);
    firstNameController.text = userModel?.firstName ?? '';
    lastNameController.text = userModel?.lastName ?? '';
    emailAddressController.text = userModel?.emailAddress ?? '';
    dateOfBirthController.text = userModel?.dateOfBirth ?? '';
    genderController.text = userModel?.gender ?? '';
    isLoading = false;
    profileScreenState.setState(() {});
  }
}
