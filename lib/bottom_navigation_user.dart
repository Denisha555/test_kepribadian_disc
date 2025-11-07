import 'package:aplikasi_tes_kepribadian/main_menu.dart';
import 'package:aplikasi_tes_kepribadian/profil.dart';
import 'package:flutter/material.dart';

class BottomNavigationUser extends StatefulWidget {
  final String username;
  final String nama;
  final String email;
  final String umur;
  final String jabatan;
  final String bidang;
  final String tipeDisc;
  
  const BottomNavigationUser({
    super.key,
    required this.username,
    required this.nama,
    required this.email,
    required this.umur,
    required this.jabatan,
    required this.bidang,
    this.tipeDisc = '',
  });

  @override
  State<BottomNavigationUser> createState() => _BottomNavigationUserState();
}

class _BottomNavigationUserState extends State<BottomNavigationUser> {
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
      Profil(
        username: widget.username,
      ),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}