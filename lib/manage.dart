import 'package:aplikasi_tes_kepribadian/firebase/firebase_get_data.dart';
import 'package:aplikasi_tes_kepribadian/firebase/firebase_forward_chaining.dart';
import 'disc.dart';
import 'package:flutter/material.dart';

class Manage extends StatefulWidget {
  final String bidang;

  const Manage({super.key, required this.bidang});

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });

    data = await FirebaseGetData().getEmployee(widget.bidang);
   
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? const Center(child: Text('Tidak ada data'))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    
                    // Ambil tipe dengan aman
                    String tipeText = "-";
                    if (item["tipe"] != null && 
                        item["tipe"] is List && 
                        (item["tipe"] as List).isNotEmpty) {
                      final lastTipe = (item["tipe"] as List).last;
                      if (lastTipe is Map && lastTipe["hasil"] != null) {
                        tipeText = lastTipe["hasil"];
                      }
                    }
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailEmployee(data: item),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(item["nama"] ?? "Nama tidak tersedia"),
                          subtitle: Text("Tipe: $tipeText"),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

// Halaman Detail
class DetailEmployee extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailEmployee({super.key, required this.data});

  @override
  State<DetailEmployee> createState() => _DetailEmployeeState();
}

class _DetailEmployeeState extends State<DetailEmployee> {
  var hasilD = [];
  var hasilI = [];
  var hasilS = [];
  var hasilC = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var tempD = await FirebaseForwardChaining().getHasilManager("D");
      var tempI = await FirebaseForwardChaining().getHasilManager("I");
      var tempS = await FirebaseForwardChaining().getHasilManager("S");
      var tempC = await FirebaseForwardChaining().getHasilManager("C");

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

  // Helper method untuk mendapatkan tipe dengan aman
  String getTipe() {
    try {
      if (widget.data["tipe"] != null && 
          widget.data["tipe"] is List && 
          (widget.data["tipe"] as List).isNotEmpty) {
        final lastTipe = (widget.data["tipe"] as List).last;
        if (lastTipe is Map && lastTipe["hasil"] != null) {
          return lastTipe["hasil"];
        }
      }
    } catch (e) {
      print('Error getting tipe: $e');
    }
    return "-";
  }

  // Helper method untuk mendapatkan data berdasarkan tipe
  Map<String, dynamic>? getDataByType(String type) {
    List<dynamic> dataList;
    
    switch (type) {
      case "Dominance":
        dataList = hasilD;
        break;
      case "Influence":
        dataList = hasilI;
        break;
      case "Steadiness":
        dataList = hasilS;
        break;
      case "Compliance":
        dataList = hasilC;
        break;
      default:
        return null;
    }
    
    if (dataList.isNotEmpty && dataList[0] is Map<String, dynamic>) {
      return dataList[0] as Map<String, dynamic>;
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final tipe = getTipe();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Karyawan'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar dan Nama
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: const Icon(Icons.person, size: 50),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.data["nama"] ?? "Nama tidak tersedia",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: Text(
                            "Tipe: $tipe",
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Tampilkan detail berdasarkan tipe
                  _buildDetailContent(tipe),
                ],
              ),
            ),
    );
  }

  // Widget untuk menampilkan konten detail
  Widget _buildDetailContent(String tipe) {
    if (tipe == "-") {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Karyawan belum melakukan tes kepribadian',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final data = getDataByType(tipe);
    
    if (data == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Data tidak tersedia',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailSection(
          "Hal Yang Memotivasinya",
          data["Hal yang dapat memotivasinya"] ?? "Data tidak tersedia",
        ),
        const SizedBox(height: 16),
        _buildDetailSection(
          "Hal Yang Tidak Memotivasinya",
          data["Hal yang dapat membuatnya kurang termotivasi"] ?? "Data tidak tersedia",
        ),
        const SizedBox(height: 16),
        _buildDetailSection(
          "Lingkungan kerja yang ideal",
          data["Lingkungan kerja yang ideal"] ?? "Data tidak tersedia",
        ),
      ],
    );
  }

  // Widget helper untuk section detail
  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}