import 'package:flutter/material.dart';

class LatihanDrawer extends StatefulWidget {
  const LatihanDrawer({super.key});

  @override
  LatihanDrawerState createState() => LatihanDrawerState();
}

class LatihanDrawerState extends State<LatihanDrawer> {
  // Indeks halaman aktif saat ini
  int selectedIndex = 0;

  // Daftar judul untuk AppBar berdasarkan halaman aktif
  final List<String> _titles = ['Halaman Utama', 'Halaman Kedua'];

  // Daftar widget halaman tujuan
  final List<Widget> _pages = const [LatihanCircleavatar(), LatihanGridview()];

  // Fungsi untuk mengubah halaman aktif
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[selectedIndex]),
        backgroundColor: Colors.blue,
      ), // AppBar
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Salman Yusuf Alfarizy"),
              accountEmail: Text("salmanyusuf335@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "S",
                  style: TextStyle(fontSize: 40.0, color: Colors.blue),
                ), // Text
              ), // CircleAvatar
              decoration: BoxDecoration(color: Colors.blue),
            ), // UserAccounts DrawerHeader
            // Menu 1: Beranda
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              selected: selectedIndex == 0, // Highlight jika menu ini aktif
              onTap: () {
                _onItemTapped(0); // Pindah ke indeks 0
                Navigator.pop(context); // Menutup Drawer setelah diklik
              },
            ), // ListTile
            // Menu 2: Pengaturan
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Seting'),
              selected: selectedIndex == 1, // Highlight jika menu ini aktif
              onTap: () {
                _onItemTapped(1); // Pindah ke indeks 1
                Navigator.pop(context); // Menutup Drawer setelah diklik
              },
            ),
          ],
        ),
      ),
      body: _pages[selectedIndex],
    );
  }
}

class LatihanCircleavatar extends StatelessWidget {
  const LatihanCircleavatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircleAvatar(radius: 60, child: Text('B')));
  }
}

class LatihanGridview extends StatelessWidget {
  const LatihanGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: List.generate(
        6,
        (index) => Card(child: Center(child: Text('Item ${index + 1}'))),
      ),
    );
  }
}
