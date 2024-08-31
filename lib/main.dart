import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parul_seminar/screen/profile_screen/profile_screen.dart';
import 'package:parul_seminar/screen/sign_in_screen/sign_in_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase User Integration',
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? const SignInScreen() : const ProfileScreen(),
    );
  }
}
