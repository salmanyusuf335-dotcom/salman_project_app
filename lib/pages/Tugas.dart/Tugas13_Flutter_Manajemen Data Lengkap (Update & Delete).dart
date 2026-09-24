// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Tugas12_13_Flutter());
}

class Tugas12_13_Flutter extends StatelessWidget {
  const Tugas12_13_Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 12 & 13 SQFLite',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const UserListScreen(),
    );
  }
}

class UserModel {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String city;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'city': city,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      city: map['city'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('user_registration.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final dbFile = join(dbPath, filePath);

    return await openDatabase(dbFile, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        password TEXT NOT NULL,
        city TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await instance.database;
    final result = await db.query('users', orderBy: 'id DESC');

    return result.map((item) {
      return UserModel.fromMap(item);
    }).toList();
  }

  Future<int> updateUser(UserModel user) async {
    final db = await instance.database;

    return await db.update(
      'users',
      {
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'password': user.password,
        'city': user.city,
      },
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;

    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}

class UserFormScreen extends StatefulWidget {
  final UserModel? user;

  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _cityController;

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.user?.name ?? '');

    _emailController = TextEditingController(text: widget.user?.email ?? '');

    _phoneController = TextEditingController(text: widget.user?.phone ?? '');

    _passwordController = TextEditingController(
      text: widget.user?.password ?? '',
    );

    _cityController = TextEditingController(text: widget.user?.city ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = UserModel(
      id: widget.user?.id,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      city: _cityController.text.trim(),
    );

    if (widget.user == null) {
      await DatabaseHelper.instance.insertUser(user);

      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('Data berhasil ditambahkan!')),
        );
      }
    } else {
      await DatabaseHelper.instance.updateUser(user);

      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('Semua data berhasil diperbarui!')),
        );
      }
    }

    if (mounted) {
      Navigator.pop(context as BuildContext, true);
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama lengkap wajib diisi';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi';
    }

    if (!value.contains('@')) {
      return 'Format email tidak valid';
    }

    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor HP wajib diisi';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password wajib diisi';
    }

    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }

    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Asal kota wajib diisi';
    }
    return null;
  }

  InputDecoration _decoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Semua Data User' : 'Tambah Data User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: _decoration(
                  'Nama Lengkap',
                  'Masukkan nama lengkap',
                  Icons.person,
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration('Email', 'Masukkan email', Icons.email),
                validator: _validateEmail,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _decoration(
                  'Nomor HP',
                  'Masukkan nomor HP',
                  Icons.phone,
                ),
                validator: _validatePhone,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cityController,
                decoration: _decoration(
                  'Asal Kota',
                  'Masukkan asal kota',
                  Icons.location_city,
                ),
                validator: _validateCity,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveData,
                  icon: Icon(isEdit ? Icons.edit : Icons.save),
                  label: Text(isEdit ? 'Simpan Perubahan' : 'Daftar & Simpan'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
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

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UserModel> _userList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    final data = await DatabaseHelper.instance.getAllUsers();

    if (!mounted) return;

    setState(() {
      _userList = data;
      _isLoading = false;
    });
  }

  void _showDeleteDialog(UserModel user) {
    showDialog(
      context: this.context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus "${user.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                Navigator.pop(ctx);

                await DatabaseHelper.instance.deleteUser(user.id!);

                await _refreshData();

                if (mounted) {
                  ScaffoldMessenger.of(context as BuildContext).showSnackBar(
                    const SnackBar(content: Text('Data berhasil dihapus!')),
                  );
                }
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showDetailDialog(UserModel user) {
    showDialog(
      context: this.context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Detail Data User'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _detailItem('Nama Lengkap', user.name),
                _detailItem('Email', user.email),
                _detailItem('Nomor HP', user.phone),
                _detailItem('Password', user.password),
                _detailItem('Asal Kota', user.city),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Widget _detailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Future<void> _editUser(UserModel user) async {
    final result = await Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => UserFormScreen(user: user)),
    );

    if (result == true) {
      await _refreshData();
    }
  }

  Future<void> _addUser() async {
    final result = await Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => const UserFormScreen()),
    );

    if (result == true) {
      await _refreshData();
    }
  }

  Widget _buildUserCard(UserModel user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(user.name.isNotEmpty ? user.name[0].toUpperCase() : '?'),
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Email: ${user.email}\n'
          'HP: ${user.phone}\n'
          'Kota: ${user.city}',
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.visibility, color: Colors.green),
              onPressed: () {
                _showDetailDialog(user);
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                _editUser(user);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteDialog(user);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_userList.isEmpty) {
      return const Center(child: Text('Belum ada data user.'));
    }

    return ListView.builder(
      itemCount: _userList.length,
      itemBuilder: (context, index) {
        return _buildUserCard(_userList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data User SQFLite')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: const Icon(Icons.add),
      ),
    );
  }
}
