import 'package:flutter/material.dart';
import 'package:salman_project_app/constant/day15/preference_handler.dart';
import 'package:salman_project_app/extension/login_screen.dart';
import 'package:salman_project_app/extension/navigator.dart';

class SplashScreenDay15 extends StatefulWidget {
  const SplashScreenDay15({super.key});

  @override
  State<SplashScreenDay15> createState() => _SplashScreenDay15State();
}

class _SplashScreenDay15State extends State<SplashScreenDay15> {
  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  void goToLogin() async {
    await Future.delayed(Duration(seconds: 5));
    if (PreferenceHandler.isLogin == true) {
      // ignore: use_build_context_synchronously
      context.pushAndRemoveAll(HalamanTerimaKasih(email: "email"));
    } else {
      // ignore: use_build_context_synchronously
      context.pushAndRemoveAll(LoginScreenDay15());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(child: Image.asset("assets/images/Profile.jpeg")),
      ),
    );
  }
}