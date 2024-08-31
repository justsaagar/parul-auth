import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parul_seminar/app/string_extensions.dart';
import 'package:parul_seminar/user_model.dart';

class UserService {
  UserService._privateConstructor();

  static final UserService instance = UserService._privateConstructor();
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  //     ======================= Create user =======================     //
  Future<void> createUser(UserModel user, BuildContext context) async {
    try {
      await userCollection.doc(user.userId).set(user.toJson());
    } on FirebaseException catch (e) {
      'Catch exception in createUser --> ${e.message}'.logs();
      e.message?.showToast(context);
    }
  }

  //     ======================= Get current user =======================     //
  Future<UserModel?> getCurrentDataUser(BuildContext context) async {
    UserModel? userModel;
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      'UserId --> $userId'.logs();
      DocumentSnapshot doc = await userCollection.doc(userId).get();
      if (doc.data() != null) {
        userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } on FirebaseException catch (e) {
      'Catch exception in getCurrentDataUser --> ${e.message}'.logs();
      e.message?.showToast(context);
    }
    return userModel;
  }

  //     ======================= Get all users =======================     //
  Future<List<UserModel>> getAllUsers(BuildContext context) async {
    List<UserModel> allUsers = [];
    try {
      QuerySnapshot querySnapshot = await userCollection.get();
      for (var element in querySnapshot.docs) {
        Map<String, dynamic> map = element.data() as Map<String, dynamic>;
        UserModel categoryModel = UserModel.fromJson(map);
        allUsers.add(categoryModel);
      }
    } on FirebaseException catch (e) {
      'Catch exception in getAllUsers --> ${e.message}'.logs();
      e.message?.showToast(context);
    }
    return allUsers;
  }
}
