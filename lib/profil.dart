import 'package:aplikasi_tes_kepribadian/main_menu.dart';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _namaLengkapController = TextEditingController();
  final _emailController = TextEditingController();
  final _umurController = TextEditingController();
  final _bidangController = TextEditingController();
  final _tipeDiscController = TextEditingController();

  bool _isEditing = false;

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      // Navigate to Main Menu page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu()));
    } else if (index == 1) {
      // Navigate to History page
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => History()));
    } else if (index == 2) {
      // Navigate to Profile page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profil()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Text('Profil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,  
                colors: [Colors.blue.shade400, Colors.purple.shade400],
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(_isEditing ? Icons.check : Icons.edit, color: Colors.white),
              onPressed: () {
                setState(() {
                  if (_isEditing) {
                    // Simpan perubahan di sini jika diperlukan
                  }
                  _isEditing = !_isEditing;
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.only(top: 60, bottom: 120),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.blue.shade400, Colors.purple.shade400],
                  ),
                ),
                child: Text(""),
              ),
          
              // 2) CONTAINER PUTIH MENGAMBANG
              Positioned(
                top: 55,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 1000,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -70,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person_outline,
                                size: 60,
                                color: Colors.blue.shade600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "User",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
              // Form Content
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 180,
                      left: 20,
                      right: 20,
                      bottom: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade400,
                                Colors.purple.shade400,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade200.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    _tipeDiscController.text.isEmpty
                                        ? '-'
                                        : _tipeDiscController.text,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade400,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tipe DISC Anda',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _tipeDiscController.text.isEmpty
                                          ? 'Belum melakukan tes'
                                          : _getTypeName(
                                            _tipeDiscController.text,
                                          ),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.assessment_outlined,
                                color: Colors.white,
                                size: 32,
                              ),
                            ],
                          ),
                        ),
              
                        const SizedBox(height: 30),
              
                        // Informasi Pribadi Section
                        _buildSectionTitle('Informasi Pribadi'),
                        const SizedBox(height: 16),
              
  
                        _buildInputField(
                          controller: _namaLengkapController,
                          label: 'Nama Lengkap',
                          icon: Icons.person_outline,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 16),
              
                        _buildInputField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          enabled: _isEditing,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
              
                        _buildInputField(
                          controller: _umurController,
                          label: 'Umur',
                          icon: Icons.calendar_today_outlined,
                          enabled: _isEditing,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
              
                        _buildInputField(
                          controller: _bidangController,
                          label: 'Bidang',
                          icon: Icons.work_outline,
                          enabled: _isEditing,
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue.shade600,
          unselectedItemColor: Colors.grey.shade400,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade400, Colors.purple.shade400],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
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
      ),
    );
  }

  String _getTypeName(String type) {
    switch (type) {
      case 'D':
        return 'Dominance';
      case 'I':
        return 'Influence';
      case 'S':
        return 'Steadiness';
      case 'C':
        return 'Compliance';
      default:
        return 'Tidak diketahui';
    }
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _emailController.dispose();
    _umurController.dispose();
    _bidangController.dispose();
    _tipeDiscController.dispose();
    super.dispose();
  }
}