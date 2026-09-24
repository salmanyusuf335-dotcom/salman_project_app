// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas10App());
}


class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color background = Color(0xFFF5F7FA);
}


class Tugas10App extends StatelessWidget {
  const Tugas10App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulir Pendaftaran',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        useMaterial3: true,
      ),
      home: const Tugas10_Flutter(),
    );
  }
}



class Tugas10_Flutter extends StatefulWidget {
  const Tugas10_Flutter({super.key});

  @override
  State<Tugas10_Flutter> createState() => _Tugas10_FlutterState();
}

class _Tugas10_FlutterState extends State<Tugas10_Flutter> {
  final _formKey = GlobalKey<FormState>();

  

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final hpController = TextEditingController();
  final kotaController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    kotaController.dispose();

    super.dispose();
  }

  

  void daftar() {
    if (!_formKey.currentState!.validate()) {
      
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                SizedBox(width: 10),
                Text('Pendaftaran Gagal'),
              ],
            ),

            content: const Text(
              'Data yang Anda masukkan belum lengkap atau tidak valid. '
              'Silakan periksa kembali formulir pendaftaran.',
            ),

            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Perbaiki Data'),
              ),
            ],
          );
        },
      );
      return;
    }

    

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ringkasan Data'),

          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nama Lengkap: ${namaController.text}',
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ${emailController.text}',
                ),
                const SizedBox(height: 10),
                Text(
                  'Nomor HP: ${hpController.text.isEmpty ? '-' : hpController.text}',
                ),
                const SizedBox(height: 10),
                Text(
                  'Kota: ${kotaController.text}',
                ),
              ],
            ),
          ),

          actions: [
            
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Perbaiki'),
            ),

            

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HalamanKonfirmasi(
                      nama: namaController.text,
                      kota: kotaController.text,
                    ),
                  ),
                );
              },
              child: const Text('Lanjut'),
            ),
          ],
        );
      },
    );
  }

  

  Widget formInput({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,

        decoration: InputDecoration(
          labelText: label,
          hintText: hint,

          prefixIcon: Icon(icon),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Formulir Pendaftaran'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daftar Aplikasi',

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Silakan isi data diri dengan lengkap.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

             

              formInput(
                label: 'Nama Lengkap',
                hint: 'Masukkan nama lengkap',
                icon: Icons.person,
                controller: namaController,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi';
                  }
                  if (value.trim().length < 3) {
                    return 'Nama minimal 3 karakter';
                  }
                  return null;
                },
              ),

              

              formInput(
                label: 'Email',
                hint: 'Contoh: nanas@email.com',
                icon: Icons.email,
                controller: emailController,
                keyboardType:
                    TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!value.contains('@') ||
                      !value.contains('.')) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),

              
              formInput(
                label: 'Nomor HP',
                hint: 'Masukkan nomor HP (opsional)',
                icon: Icons.phone,
                controller: hpController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return null;
                  }

                  
                  if (!RegExp(r'^[0-9]+$')
                      .hasMatch(value.trim())) {
                    return 'Nomor HP hanya boleh angka';
                  }
                  if (value.trim().length < 10) {
                    return 'Nomor HP minimal 10 angka';
                  }
                  return null;
                },
              ),

             
              formInput(
                label: 'Kota',
                hint: 'Masukkan kota asal',
                icon: Icons.location_city,
                controller: kotaController,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Kota wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),


              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: daftar,
                  icon: const Icon(
                    Icons.app_registration,
                  ),
                  label: const Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class HalamanKonfirmasi extends StatelessWidget {
  final String nama;
  final String kota;

  const HalamanKonfirmasi({
    super.key,
    required this.nama,
    required this.kota,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text(
          'Konfirmasi Pendaftaran',
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

     

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
            
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 90,
              ),
              const SizedBox(height: 24),
              

              const Text(
                'Pendaftaran Berhasil!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

             const SizedBox(height: 16),

              
              Text(
                'Terima kasih, $nama dari $kota telah mendaftar.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),

             

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}