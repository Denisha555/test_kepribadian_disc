import 'package:aplikasi_tes_kepribadian/bottom_navigation_manager.dart';
import 'package:aplikasi_tes_kepribadian/bottom_navigation_user.dart';
import 'package:aplikasi_tes_kepribadian/disc.dart';
import 'package:aplikasi_tes_kepribadian/firebase/firebase_edit_data.dart';
import 'package:aplikasi_tes_kepribadian/firebase/firebase_masuk_daftar.dart';
import 'package:aplikasi_tes_kepribadian/main_menu.dart';
import 'package:flutter/material.dart';

class Hasil extends StatefulWidget {
  final Map<String, int> scores;
  final String username;

  const Hasil({super.key, required this.scores, required this.username});

  @override
  State<Hasil> createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
  String _jabatan = '';
  Map<String, dynamic>? userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    _jabatan = await FirebaseMasukDaftar().checkJabatan(widget.username);
    userData = await FirebaseMasukDaftar().getData(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    final highestType =
        widget.scores.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    // Warna untuk setiap tipe kepribadian
    Map<String, Color> typeColors = {
      'D': Colors.green.shade400,
      'I': Colors.red.shade400,
      'S': Colors.blue.shade400,
      'C': Colors.orange.shade400,
    };

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Hasil Tes',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Header Card dengan Gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade400, Colors.purple.shade400],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200.withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      size: 64,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Selamat!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tes kepribadian Anda telah selesai',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tipe Kepribadian Dominan Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Tipe Kepribadian Dominan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: typeColors[highestType],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade200.withOpacity(0.5),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          highestType,
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getTypeName(highestType),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Grafik Skor
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.bar_chart_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Distribusi Skor',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...widget.scores.entries.map((entry) {
                      int maxScore = widget.scores.values.reduce(
                        (a, b) => a > b ? a : b,
                      );
                      double percentage = entry.value / maxScore;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${entry.key} - ${_getTypeName(entry.key)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Text(
                                  '${entry.value}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: typeColors[entry.key],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: percentage,
                                minHeight: 12,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  typeColors[entry.key]!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Detail Kepribadian Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Detail Kepribadian',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    if (highestType == 'D') ...[
                      _buildDetailItem(
                        title: "Gaya Bekerja",
                        content: D_user_result['Gaya bekerja']!,
                      ),
                      _buildDetailItem(
                        title: "Hal-hal yang Dianggap Penting",
                        content:
                            D_user_result['Hal-hal yang dianggap penting']!,
                      ),
                      _buildDetailItem(
                        title: "Rekan Kerja yang Dibutuhkan",
                        content: D_user_result['Rekan kerja yang dibutuhkan']!,
                      ),
                      _buildDetailItem(
                        title: "Saran",
                        content: D_user_result['Saran']!,
                        isLast: true,
                      ),
                    ] else if (highestType == 'I') ...[
                      _buildDetailItem(
                        title: "Gaya Bekerja",
                        content: I_user_result['Gaya bekerja']!,
                      ),
                      _buildDetailItem(
                        title: "Hal-hal yang Dianggap Penting",
                        content:
                            I_user_result['Hal-hal yang dianggap penting']!,
                      ),
                      _buildDetailItem(
                        title: "Rekan Kerja yang Dibutuhkan",
                        content: I_user_result['Rekan kerja yang dibutuhkan']!,
                      ),
                      _buildDetailItem(
                        title: "Saran",
                        content: I_user_result['Saran']!,
                        isLast: true,
                      ),
                    ] else if (highestType == 'S') ...[
                      _buildDetailItem(
                        title: "Gaya Bekerja",
                        content: S_user_result['Gaya bekerja']!,
                      ),
                      _buildDetailItem(
                        title: "Hal-hal yang Dianggap Penting",
                        content:
                            S_user_result['Hal-hal yang dianggap penting']!,
                      ),
                      _buildDetailItem(
                        title: "Rekan Kerja yang Dibutuhkan",
                        content: S_user_result['Rekan kerja yang dibutuhkan']!,
                      ),
                      _buildDetailItem(
                        title: "Saran",
                        content: S_user_result['Saran']!,
                        isLast: true,
                      ),
                    ] else if (highestType == 'C') ...[
                      _buildDetailItem(
                        title: "Gaya Bekerja",
                        content: C_user_result['Gaya bekerja']!,
                      ),
                      _buildDetailItem(
                        title: "Hal-hal yang Dianggap Penting",
                        content:
                            C_user_result['Hal-hal yang dianggap penting']!,
                      ),
                      _buildDetailItem(
                        title: "Rekan Kerja yang Dibutuhkan",
                        content: C_user_result['Rekan kerja yang dibutuhkan']!,
                      ),
                      _buildDetailItem(
                        title: "Saran",
                        content: C_user_result['Saran']!,
                        isLast: true,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tombol Aksi
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        if (_jabatan == "Manager") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BottomNavigationManager(
                                    username: widget.username,
                                    nama: userData!["nama"],
                                    umur: userData!["umur"],
                                    email: userData!["email"],
                                    jabatan: userData!["jabatan"],
                                    bidang: userData!["bidang"],
                                  ),
                            ),
                            (route) => false,
                          );
                        } else if (_jabatan == "Karyawan") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BottomNavigationUser(
                                    username: widget.username,
                                    nama: userData!["nama"],
                                    umur: userData!["umur"],
                                    email: userData!["email"],
                                    jabatan: userData!["jabatan"],
                                    bidang: userData!["bidang"],
                                  ),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      label: Text('Beranda'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade400,
                        side: BorderSide(color: Colors.blue.shade400, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        FirebaseEditData().updateTipe(
                          widget.username,
                          _getTypeName(highestType),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tipe berhasil disimpan'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        if (_jabatan == "Manager") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BottomNavigationManager(
                                    username: widget.username,
                                    nama: userData!["nama"],
                                    umur: userData!["umur"],
                                    email: userData!["email"],
                                    jabatan: userData!["jabatan"],
                                    bidang: userData!["bidang"],
                                  ),
                            ),
                            (context) => false,
                          );
                        } else if (_jabatan == "Karyawan") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BottomNavigationUser(
                                    username: widget.username,
                                    nama: userData!["nama"],
                                    umur: userData!["umur"],
                                    email: userData!["email"],
                                    jabatan: userData!["jabatan"],
                                    bidang: userData!["bidang"],
                                  ),
                            ),
                            (context) => false,
                          );
                        }
                      },
                      label: Text('Simpan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required String title,
    required String content,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
          textAlign: TextAlign.justify,
        ),
        if (!isLast) const SizedBox(height: 20),
      ],
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
        return '';
    }
  }
}
