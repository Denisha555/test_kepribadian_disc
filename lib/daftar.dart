import 'package:aplikasi_tes_kepribadian/firebase/firebase_masuk_daftar.dart';
import 'package:aplikasi_tes_kepribadian/main.dart';
import 'package:flutter/material.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _namaLengkapController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  final _umurController = TextEditingController();
  final _bidangController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _jabatan = '';
  String _bidang = '';
  String _gender = '';

  final List<String> _genderList = [
    'Female',
    'Male',
  ];
  final List<String> _jabatanList = [
    'Manager', 
    'Karyawan'];
  final List<String> _bidangList = [
    'IT',
    'HR',
    'Finance',
    'Marketing',
    'Sales',
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _namaLengkapController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _umurController.dispose();
    _bidangController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _jabatan = _jabatanList[0];
    _bidang = _bidangList[0];
    _gender = _genderList[0];
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        fontSize: 15,
        color: enabled ? Colors.black87 : Colors.grey.shade600,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: enabled ? Colors.blue.shade400 : Colors.grey.shade500,
        ),
        prefixIcon: Icon(
          icon,
          color: enabled ? Colors.blue.shade400 : Colors.grey.shade400,
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade100, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required List<String> items,
    required String label,
  }) {
    return DropdownButtonFormField<String>(
      value: items[0],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue.shade400),
        prefixIcon: Icon(Icons.badge, color: Colors.blue.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade100, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      hint: Text('Pilih $label'),
      items:
          items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          if (label == "Jabatan") {
            _jabatan = newValue!;
          } else if (label == "Bidang") {
            _bidang = newValue!;
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Silakan pilih $label';
        }
        return null;
      },
    );
  }

  void _handleDaftar() {
    if (_formKey.currentState!.validate()) {
      FirebaseMasukDaftar().validate(_usernameController.text, 'username').then((
        isUsernameTaken,
      ) {
        if (isUsernameTaken) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Username sudah digunakan. Silakan pilih yang lain.',
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        } else {
          FirebaseMasukDaftar().createAccount(
            _usernameController.text,
            _passwordController.text,
            _namaLengkapController.text,
            _emailController.text,
            _umurController.text,
            _jabatan,
            _bidang,
            _gender
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pendaftaran berhasil!'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Daftar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),

                  // Username
                  _buildTextField(
                    controller: _usernameController,
                    label: "Username",
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      if (value.length < 4) {
                        return 'Username minimal 4 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password
                  _buildTextField(
                    controller: _passwordController,
                    label: "Password",
                    icon: Icons.lock,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  _buildTextField(
                    controller: _confirmPasswordController,
                    label: "Konfirmasi Password",
                    icon: Icons.lock,
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi password tidak boleh kosong';
                      }
                      if (value != _passwordController.text) {
                        return 'Password tidak cocok';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Nama Lengkap
                  _buildTextField(
                    controller: _namaLengkapController,
                    label: "Nama Lengkap",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama lengkap tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _buildTextField(
                    controller: _emailController,
                    label: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Umur
                  _buildTextField(
                    controller: _umurController,
                    label: "Umur",
                    icon: Icons.calendar_today,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Umur tidak boleh kosong';
                      }
                      final umur = int.tryParse(value);
                      if (umur == null || umur < 17 || umur > 100) {
                        return 'Umur harus antara 17-100 tahun';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  //Gender (Dropdown)
                  _buildDropdownField(items: _genderList, label: "Gender"),
                  const SizedBox(height: 16),

                  // Jabatan (Dropdown)
                  _buildDropdownField(items: _jabatanList, label: "Jabatan"),
                  const SizedBox(height: 16),

                  // Bidang (Dropdown)
                  _buildDropdownField(items: _bidangList, label: "Bidang"),
                  const SizedBox(height: 24),

                  // Tombol Daftar
                  ElevatedButton(
                    onPressed: _handleDaftar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.blue.shade200.withOpacity(0.5),
                    ),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
