import 'package:flutter/material.dart';
import 'package:salman_project_app/constant/day15/preference_handler.dart';
import 'package:salman_project_app/extension/login_screen.dart';
import 'package:salman_project_app/extension/navigator.dart';
import 'package:salman_project_app/pages/Tugas.dart/Tugas11_Flutter_Implementasi%20Sesi%20Pengguna%20(Shared%20Preferences).dart';

class Tugas11_Flutter extends StatefulWidget {
  const Tugas11_Flutter({super.key});

  @override
  State<Tugas11_Flutter> createState() => _Tugas11_FlutterState();
}

class _Tugas11_FlutterState extends State<Tugas11_Flutter> {
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
      context.pushAndRemoveAll(LoginScreen());
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
