void main() {
  // 1. Variabel Informasi Toko
  final String namaToko = "Salman";
  final int tahunBerdiri = 2024;

  // 2. List of Maps (Daftar Produk)
  // Memperbaiki sintaks yang salah pada elemen pertama dan list secara umum
  List<Map<String, dynamic>> daftarProduk = [
    {'nama': 'Laptop', 'harga': 8500000},
    {'nama': 'Mouse', 'harga': 150000},
    {
      'nama': 'Keyboard', // Memperbaiki penulisan Keybord menjadi Keyboard
      'harga': 450000,
    },
  ];

  // 3. Menampilkan Informasi Toko
  // ignore: avoid_print
  print("=== INFORMASI TOKO ===");
  // ignore: avoid_print
  print("Nama Toko: $namaToko");
  // ignore: avoid_print
  print("Tahun Berdiri: $tahunBerdiri");
  // ignore: avoid_print
  print("");

  // 4. Menampilkan Daftar Produk
  // ignore: avoid_print
  print("=== DAFTAR PRODUK ===");

  // Menggunakan perulangan (loop) agar lebih efisien dan dinamis daripada akses indeks manual
  for (int i = 0; i < daftarProduk.length; i++) {
    final produk = daftarProduk[i];
    // ignore: avoid_print
    print("${i + 1}. ${produk['nama']} - Rp ${produk['harga']}");
  }
}
