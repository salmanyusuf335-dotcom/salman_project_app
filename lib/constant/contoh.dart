// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:salman_project_app/constant/app_assets.dart';
import 'package:salman_project_app/constant/app_colors.dart';
import 'package:salman_project_app/constant/app_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ReusablePage(),
    );
  }
}

class ReusablePage extends StatelessWidget {
  const ReusablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reusable Flutter',
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: AppFonts.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Katalog Alat Berat',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: AppFonts.bold,
              ),
            ),

            const SizedBox(height: 20),

            Image.asset(
              AppAssets.excavator,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 15),

            Text(
              'Excavator',
              style: textTheme.titleLarge?.copyWith(fontWeight: AppFonts.bold),
            ),

            const SizedBox(height: 10),

            Text(
              'Alat berat untuk menggali dan '
              'memindahkan tanah.',
              style: textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              color: AppColors.background,
              child: Text(
                'Produk tersedia',
                style: TextStyle(
                  color: AppColors.success,
                  fontWeight: AppFonts.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
