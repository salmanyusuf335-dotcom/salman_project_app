import 'package:flutter/material.dart';

class LoginScreenDB extends StatefulWidget {
  const LoginScreenDB({super.key});

  @override
  State<LoginScreenDB> createState() => _LoginScreenDBState();
}

class _LoginScreenDBState extends State<LoginScreenDB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
        
                  // =========================
                  // ICON
                  // =========================
                  const Icon(
                    Icons.lock,
                    size: 80,
                    color: Colors.blue,
                  ),
        
                  const SizedBox(height: 24),
        
                  // =========================
                  // TITLE
                  // =========================
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        
                  const SizedBox(height: 8),
        
                  // =========================
                  // SUBTITLE
                  // =========================
                  const Text(
                    'Silakan masuk ke akun Anda',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
        
                  const SizedBox(height: 32),
        
                  // =========================
                  // EMAIL
                  // =========================
                  TextFormField(
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
        
                  // =========================
                  // PASSWORD
                  // =========================
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
        
                  // =========================
                  // BUTTON
                  // =========================
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Login',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}