// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LatihanCircleavatar extends StatelessWidget {
  const LatihanCircleavatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar CircleAvatar'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: CircleAvatar(
          radius: 100, // Lingkaran luar (berfungsi sebagai border)
          backgroundColor: Colors.blue, // Warna border
          child: CircleAvatar(
            radius: 90, // Lingkaran dalam (poto profil asli)
            backgroundImage: AssetImage('assets/images/Profile.jpeg'),
          ),
        ),
      ),
    );
  }
}
