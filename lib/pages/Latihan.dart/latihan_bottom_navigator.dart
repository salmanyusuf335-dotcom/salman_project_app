import 'package:flutter/material.dart';
import 'package:salman_project_app/pages/Tugas.dart/Tugas7_Flutter.dart';

class LatihanBottomNavigator extends StatefulWidget {
  const LatihanBottomNavigator({super.key});

  @override
  State<LatihanBottomNavigator> createState() => _LatihanBottomNavigatorState();
}

class _LatihanBottomNavigatorState extends State<LatihanBottomNavigator> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Center(
      child: Text('Halaman Beranda 1', style: TextStyle(fontSize: 24)),
    ),
    const Tugas7_Flutter(),
    const Center(
      child: Text('Halaman Profil 2', style: TextStyle(fontSize: 24)),
    ),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tugas 7',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Tentang'),
        ],
      ),
    );
  }
}
