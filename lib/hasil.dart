import 'package:aplikasi_tes_kepribadian/bottom_navigation_manager.dart';
import 'package:aplikasi_tes_kepribadian/bottom_navigation_user.dart';
import 'package:aplikasi_tes_kepribadian/firebase/firebase_edit_data.dart';
import 'package:aplikasi_tes_kepribadian/firebase/firebase_forward_chaining.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Hasil extends StatefulWidget {
  final Map<String, int> scores;
  final String highestType;
  final String username;
  final String jabatan;
  final Map<String, dynamic> userData;

  const Hasil({
    super.key,
    required this.scores,
    required this.highestType,
    required this.username,
    required this.jabatan,
    required this.userData,
  });

  @override
  State<Hasil> createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
  var hasilD = [];
  var hasilI = [];
  var hasilS = [];
  var hasilC = [];
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      var tempD = await FirebaseForwardChaining().getHasilKaryawan("D");
      var tempI = await FirebaseForwardChaining().getHasilKaryawan("I");
      var tempS = await FirebaseForwardChaining().getHasilKaryawan("S");
      var tempC = await FirebaseForwardChaining().getHasilKaryawan("C");

      if (mounted) {
        setState(() {
          hasilD = tempD;
          hasilI = tempI;
          hasilS = tempS;
          hasilC = tempC;
          isLoading = false; 
        });
      }
    } catch (e) {
      print('Error loading data: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Map<String, Color> typeColors = {
    'D': Colors.green.shade400,
    'I': Colors.red.shade400,
    'S': Colors.blue.shade400,
    'C': Colors.orange.shade400,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Hasil Tes',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading ? 
      Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
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
                        color: typeColors[widget.highestType],
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
                          widget.highestType,
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
                      _getTypeName(widget.highestType),
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
                  mainAxisAlignment: MainAxisAlignment.start,
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

                    Row(
                      children: [
                        _buildDonutChart(),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      "Dominance",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      "Influence",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      "Steadiness",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      "Compliance",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

                    // Tampilkan loading atau konten
                    if (isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else
                      _buildPersonalityDetails(),
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
                        if (widget.jabatan == "Manager") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationManager(
                                username: widget.username,
                                nama: widget.userData["nama"],
                                umur: widget.userData["umur"],
                                email: widget.userData["email"],
                                jabatan: widget.userData["jabatan"],
                                bidang: widget.userData["bidang"],
                              ),
                            ),
                            (route) => false,
                          );
                        } else if (widget.jabatan == "Karyawan") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationUser(
                                username: widget.username,
                                nama: widget.userData["nama"],
                                umur: widget.userData["umur"],
                                email: widget.userData["email"],
                                jabatan: widget.userData["jabatan"],
                                bidang: widget.userData["bidang"],
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
                          _getTypeName(widget.highestType),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tipe berhasil disimpan'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        if (widget.jabatan == "Manager") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationManager(
                                username: widget.username,
                                nama: widget.userData["nama"],
                                umur: widget.userData["umur"],
                                email: widget.userData["email"],
                                jabatan: widget.userData["jabatan"],
                                bidang: widget.userData["bidang"],
                              ),
                            ),
                            (context) => false,
                          );
                        } else if (widget.jabatan == "Karyawan") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationUser(
                                username: widget.username,
                                nama: widget.userData["nama"],
                                umur: widget.userData["umur"],
                                email: widget.userData["email"],
                                jabatan: widget.userData["jabatan"],
                                bidang: widget.userData["bidang"],
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

  // Method terpisah untuk menampilkan detail kepribadian
  Widget _buildPersonalityDetails() {
    List<dynamic> currentData = [];
    
    // Pilih data berdasarkan tipe tertinggi
    switch (widget.highestType) {
      case 'D':
        currentData = hasilD;
        break;
      case 'I':
        currentData = hasilI;
        break;
      case 'S':
        currentData = hasilS;
        break;
      case 'C':
        currentData = hasilC;
        break;
    }

    // Cek apakah data tersedia dan memiliki elemen
    if (currentData.isEmpty) {
      return Center(
        child: Text(
          'Data tidak tersedia',
          style: TextStyle(color: Colors.grey.shade600),
        ),
      );
    }

    // PERBAIKAN BUG: Untuk tipe 'C', gunakan hasilC bukan hasilS
    final data = currentData[0];
    
    return Column(
      children: [
        _buildDetailItem(
          title: "Gaya Bekerja",
          content: data['Gaya Bekerja'] ?? 'Data tidak tersedia',
        ),
        _buildDetailItem(
          title: "Hal-hal yang Dianggap Penting",
          content: data['Hal-hal yang dianggap penting'] ?? 'Data tidak tersedia',
        ),
        _buildDetailItem(
          title: "Rekan Kerja yang Dibutuhkan",
          content: data['Rekan kerja yang dibutuhkan'] ?? 'Data tidak tersedia',
        ),
        _buildDetailItem(
          title: "Saran",
          content: data['Saran'] ?? 'Data tidak tersedia',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildDonutChart() {
    return SizedBox(
      height: 200,
      width: 150,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 20,
          sectionsSpace: 1,
          sections: widget.scores.entries.map((entry) {
            final color = typeColors[entry.key] ?? Colors.blue;
            return PieChartSectionData(
              value: entry.value.toDouble(),
              title: '${entry.value}',
              color: color,
              radius: 60,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
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