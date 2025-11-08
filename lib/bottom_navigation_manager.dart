import 'package:aplikasi_tes_kepribadian/history.dart';
import 'package:aplikasi_tes_kepribadian/manage.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_tes_kepribadian/main_menu.dart';
import 'package:aplikasi_tes_kepribadian/profil.dart';

class BottomNavigationManager extends StatefulWidget {
  final String username;
  final String nama;
  final String email;
  final String umur;
  final String jabatan;
  final String bidang;
  
  const BottomNavigationManager({
    super.key,
    required this.username,
    required this.nama,
    required this.email,
    required this.umur,
    required this.jabatan,
    required this.bidang,
  });

  @override
  State<BottomNavigationManager> createState() => _BottomNavigationManagerState();
}

class _BottomNavigationManagerState extends State<BottomNavigationManager> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = [
      MainMenu(
        username: widget.username,
      ), 
      History(
        username: widget.username,
      ),
      Manage(
        bidang: widget.bidang,
      ),
      Profil(
        username: widget.username,
      ),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // Let the BottomNavigationBar control the colors for icons and labels
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(color: Colors.purple),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts), label: 'Manage'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
