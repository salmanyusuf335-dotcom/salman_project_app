import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas9_Flutter());
}

// ======================================================
// HALAMAN UTAMA
// ======================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kategori Toko',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Tugas9_Flutter(),
    );
  }
}

class Tugas9_Flutter extends StatelessWidget {
  const Tugas9_Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kategori Toko'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Map'),
              Tab(text: 'Model'),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            // ==========================================
            // 1. LIST STRING
            // ==========================================
            ListKategori(),

            // ==========================================
            // 2. LIST MAP
            // ==========================================
            ListKategoriMap(),

            // ==========================================
            // 3. MODEL
            // ==========================================
            ListProdukPage(),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// HALAMAN 1 - LIST STRING
// ======================================================

class ListKategori extends StatelessWidget {
  const ListKategori({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kategori.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(kategori[index]),
        );
      },
    );
  }
}

// ======================================================
// HALAMAN 2 - LIST MAP
// ======================================================

class ListKategoriMap extends StatelessWidget {
  const ListKategoriMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kategoriMap.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(kategoriMap[index]['icon']),
          title: Text(kategoriMap[index]['nama']),
        );
      },
    );
  }
}

// ======================================================
// HALAMAN 3 - MODEL
// ======================================================

class ListProdukPage extends StatelessWidget {
  const ListProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produk.length,
      itemBuilder: (context, index) {
        return ListProduk(produk: produk[index]);
      },
    );
  }
}

// ======================================================
// 1. LIST STRING
// ======================================================

final List<String> kategori = [
  'Buah',
  'Sayuran',
  'Elektronik',
  'Pakaian Pria',
  'Barang Bekas',
  'Peralatan Olahraga',
  'Buku & Majalah',
  'Peralatan Dapur',
  'Makanan Ringan',
  'Minuman',
];

// ======================================================
// 2. LIST MAP
// ======================================================

final List<Map<String, dynamic>> kategoriMap = [
  {'nama': 'Melon', 'icon': Icons.food_bank},
  {'nama': 'Wortel', 'icon': Icons.eco},
  {'nama': 'Elektronik', 'icon': Icons.devices},
  {'nama': 'Pakaian Pria', 'icon': Icons.checkroom},
  {'nama': 'Barang Bekas', 'icon': Icons.recycling},
  {'nama': 'Alat Tulis Kantor', 'icon': Icons.edit},
  {'nama': 'Buku & Majalah', 'icon': Icons.menu_book},
  {'nama': 'Peralatan Dapur', 'icon': Icons.kitchen},
  {'nama': 'Makanan Ringan', 'icon': Icons.fastfood},
  {'nama': 'Minuman', 'icon': Icons.local_drink},
];

// ======================================================
// MODEL PRODUK
// ======================================================

class Produk {
  final String nama;
  final String deskripsi;
  final String gambar;
  final String harga;

  Produk({
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.harga,
  });
}

// ======================================================
// DATA PRODUK
// ======================================================

final List<Produk> produk = [
  Produk(
    nama: 'Melon',
    deskripsi: 'Buah Melon segar dan berkualitas.',
    gambar: 'assets/images/melon.jpg',
    harga: 'Rp100.000/kg',
  ),
  Produk(
    nama: 'Wortel',
    deskripsi: 'Sangat dikenal untuk menjaga kesehatan mata.',
    gambar: 'assets/images/wortel.jpg',
    harga: 'Rp65.000/kg',
  ),
  Produk(
    nama: 'Headphone',
    deskripsi: 'Headphone nyaman dengan kualitas suara jernih.',
    gambar: 'assets/images/handphone.jpg',
    harga: 'Rp3.500.000',
  ),
  Produk(
    nama: 'Kemeja Pria',
    deskripsi: 'Kemeja pria dengan bahan nyaman digunakan.',
    gambar: 'assets/images/kemeja.jpg',
    harga: 'Rp300.000',
  ),
  Produk(
    nama: 'Kaleng Bekas',
    deskripsi: 'Bekas wadah susu kental manis.Sifatnya yang kuat cocok dijadikan pot bunga',
    gambar: 'assets/images/kaleng.jpg',
    harga: 'Rp50.000',
  ),
  Produk(
    nama: 'Buku Tulis',
    deskripsi: 'Buku tulis untuk sekolah dan keperluan kantor.',
    gambar: 'assets/images/buku.jpg',
    harga: 'Rp75.000',
  ),
  Produk(
    nama: 'Panci',
    deskripsi: 'Panci berkualitas untuk kebutuhan memasak.',
    gambar: 'assets/images/panci.jpg',
    harga: 'Rp300.000',
  ),
  Produk(
    nama: 'Keripik Kentang',
    deskripsi: 'Makanan ringan renyah dan cocok untuk bersantai.',
    gambar: 'assets/images/keripik.jpg',
    harga: 'Rp30.000',
  ),
  Produk(
    nama: 'Sepatu Olahraga',
    deskripsi: 'Sepatu olahraga nyaman untuk berbagai aktivitas.',
    gambar: 'assets/images/sepatu.jpg',
    harga: 'Rp2.500.000',
  ),
  Produk(
    nama: 'Botol Minum',
    deskripsi: 'Botol minum praktis untuk dibawa bepergian.',
    gambar: 'assets/images/botol.jpg',
    harga: 'Rp500.000',
  ),
];

// ======================================================
// WIDGET LIST PRODUK
// ======================================================

class ListProduk extends StatelessWidget {
  final Produk produk;

  const ListProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),

        // GAMBAR
        leading: Image.asset(
          produk.gambar,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported, size: 50);
          },
        ),

        // NAMA PRODUK
        title: Text(
          produk.nama,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),

        // DESKRIPSI + HARGA
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(produk.deskripsi),
            const SizedBox(height: 5),
            Text(
              produk.harga,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
