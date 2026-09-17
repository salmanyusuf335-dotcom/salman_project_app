import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas7_Flutter());
}

class Tugas7_Flutter extends StatelessWidget {
  const Tugas7_Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Input Interaktif',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Menu yang sedang dipilih
  String halaman = 'Checkbox';

  // Checkbox
  bool setuju = false;

  // Switch
  bool modeGelap = false;

  // Dropdown
  String? kategori;

  // Date Picker
  DateTime? tanggalLahir;

  // Time Picker
  TimeOfDay? waktuPengingat;

  // Membuka Date Picker
  Future<void> pilihTanggal() async {
    DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime(2009, 5, 5),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (tanggal != null) {
      setState(() {
        tanggalLahir = tanggal;
      });
    }
  }

  // Membuka Time Picker
  Future<void> pilihWaktu() async {
    TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (waktu != null) {
      setState(() {
        waktuPengingat = waktu;
      });
    }
  }

  // Format tanggal Indonesia
  String formatTanggal(DateTime tanggal) {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${tanggal.day} ${bulan[tanggal.month - 1]} ${tanggal.year}';
  }

  // Format waktu
  String formatWaktu(TimeOfDay waktu) {
    final jam = waktu.hourOfPeriod.toString().padLeft(2, '0');
    final menit = waktu.minute.toString().padLeft(2, '0');
    final periode = waktu.period == DayPeriod.am ? 'AM' : 'PM';

    return '$jam:$menit $periode';
  }

  // Isi Body berdasarkan menu
  Widget tampilkanForm() {
    switch (halaman) {
      case 'Checkbox':
        return formCheckbox();

      case 'Switch':
        return formSwitch();

      case 'Dropdown':
        return formDropdown();

      case 'Tanggal':
        return formTanggal();

      case 'Jam':
        return formJam();

      default:
        return formCheckbox();
    }
  }

  // ================= CHECKBOX =================

  Widget formCheckbox() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Syarat & Ketentuan',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.only(top: 20), child: SizedBox()),
          CheckboxListTile(
            title: const Text('Saya menyetujui semua persyaratan yang berlaku'),
            value: setuju,
            onChanged: (value) {
              setState(() {
                setuju = value ?? false;
              });
            },
          ),
          const SizedBox(height: 10),
          Text(
            setuju
                ? 'Lanjutkan pendaftaran diperbolehkan'
                : 'Anda belum bisa melanjutkan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: setuju ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // ================= SWITCH =================

  Widget formSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mode Gelap',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        SwitchListTile(
          title: const Text('Aktifkan Mode Gelap'),
          value: modeGelap,
          onChanged: (value) {
            setState(() {
              modeGelap = value;
            });
          },
        ),

        const SizedBox(height: 10),

        Text(
          modeGelap ? 'Mode Gelap Aktif' : 'Mode Terang Aktif',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ================= DROPDOWN =================

  Widget formDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Kategori Produk',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Kategori Produk',
            border: OutlineInputBorder(),
          ),
          initialValue: kategori,
          items: const [
            DropdownMenuItem(value: 'Elektronik', child: Text('Elektronik')),
            DropdownMenuItem(value: 'Pakaian', child: Text('Pakaian')),
            DropdownMenuItem(value: 'Makanan', child: Text('Makanan')),
            DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
          ],
          onChanged: (value) {
            setState(() {
              kategori = value;
            });
          },
        ),

        const SizedBox(height: 20),

        Text(
          kategori == null
              ? 'Silakan pilih kategori'
              : 'Anda memilih kategori: $kategori',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ================= TANGGAL =================

  Widget formTanggal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Tanggal Lahir',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 25),

        ElevatedButton.icon(
          onPressed: pilihTanggal,
          icon: const Icon(Icons.calendar_month),
          label: const Text('Pilih Tanggal Lahir'),
        ),

        const SizedBox(height: 20),

        Text(
          tanggalLahir == null
              ? 'Belum memilih tanggal lahir'
              : 'Tanggal Lahir: ${formatTanggal(tanggalLahir!)}',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ================= JAM =================

  Widget formJam() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Atur Pengingat',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 25),

        ElevatedButton.icon(
          onPressed: pilihWaktu,
          icon: const Icon(Icons.access_time),
          label: const Text('Pilih Waktu Pengingat'),
        ),

        const SizedBox(height: 20),

        Text(
          waktuPengingat == null
              ? 'Belum mengatur waktu pengingat'
              : 'Pengingat diatur pukul: ${formatWaktu(waktuPengingat!)}',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ================= DRAWER =================

  Widget drawerMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.dashboard, color: Colors.white, size: 50),
                SizedBox(height: 10),
                Text(
                  'Form Input Interaktif',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('Checkbox'),
            onTap: () {
              setState(() {
                halaman = 'Checkbox';
              });
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.toggle_on),
            title: const Text('Switch'),
            onTap: () {
              setState(() {
                halaman = 'Switch';
              });
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.arrow_drop_down_circle),
            title: const Text('Dropdown'),
            onTap: () {
              setState(() {
                halaman = 'Dropdown';
              });
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Tanggal'),
            onTap: () {
              setState(() {
                halaman = 'Tanggal';
              });
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Jam'),
            onTap: () {
              setState(() {
                halaman = 'Jam';
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(halaman),
        backgroundColor: modeGelap ? Colors.grey[900] : Colors.blue,
        foregroundColor: Colors.white,
      ),

      drawer: drawerMenu(),

      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: modeGelap ? Colors.grey[900] : const Color(0xFFFFF7FF),
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: DefaultTextStyle(
              style: TextStyle(color: modeGelap ? Colors.white : Colors.black),
              child: tampilkanForm(),
            ),
          ),
        ),
      ),
    );
  }
}
