// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:salman_project_app/constant/day15/preference_handler.dart';
import 'package:salman_project_app/extension/login_screen.dart';
import 'package:salman_project_app/extension/navigator.dart';

class Tugas11_Flutter extends StatefulWidget {
  const Tugas11_Flutter({super.key});

  @override
  State<Tugas11_Flutter> createState() => _Tugas11_FlutterState();
}

class _Tugas11_FlutterState extends State<Tugas11_Flutter> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock, size: 80, color: Colors.blue),

                    const SizedBox(height: 24),

                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Silakan masuk ke akun Anda',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 32),

                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email wajib diisi';
                        } else if (!value.contains('@')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Masukkan email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Masukkan password',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          // textStyle: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Data '),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email: ${emailController.text}'),
                                  ],
                                ), // Column
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                      PreferenceHandler.setLogin(true);
                                      context.push(
                                        HalamanTerimaKasih(
                                          email: emailController.text,
                                        ),
                                      );
                                    },
                                    child: Text('Lanjutkan'),
                                  ), // TextButtontton
                                ],
                              ), // AlertDialog
                            );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HalamanTerimaKasih extends StatelessWidget {
  final String email;
  const HalamanTerimaKasih({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Konfirmasi')),
      body: Column(
        children: [
          Center(
            child: Text(
              'Terima kasih, $email',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ), // Text
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                PreferenceHandler.logOut();
                context.pushAndRemoveAll(LoginScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                // textStyle: TextStyle(color: Colors.white),
              ),
              child: Text("Logout"),
            ),
          ),
        ],
      ), // Center
    ); // Scaffold
  }
}
