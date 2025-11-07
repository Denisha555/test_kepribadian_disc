import 'package:aplikasi_tes_kepribadian/firebase/firebase_get_data.dart';
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
      appBar: AppBar(title: const Text('Manage')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : data.isEmpty
              ? const Center(child: Text('Tidak ada data'))
              : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
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
                        subtitle: Text("Tipe: ${item["tipe"] ?? "-"}"),
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
class DetailEmployee extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailEmployee({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Karyawan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 50),
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
                    data["nama"] ?? "Nama tidak tersedia",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      "Tipe: ${data["tipe"] ?? "-"}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            if (data["tipe"] == "Dominance") ...[
              Text(
                'Hal Yang Memotivasinya',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(D_manager_result["Hal yang dapat memotivasinya"]!, textAlign: TextAlign.justify,),

              SizedBox(height: 16,),
              Text(
                "Hal Yang Tidak Memotivasinya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(D_manager_result["Hal yang dapat membuatnya kurang termotivasi"]!, textAlign: TextAlign.justify,),

              SizedBox(height: 16,),
              Text(
                "Lingkungan kerja yang ideal",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(D_manager_result["Lingkungan kerja yang ideal"]!, textAlign: TextAlign.justify,),
            ] else if (data["tipe"] == "Influence") ... [
              Text(
                "Hal Yang Memotivasinya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(I_manager_result["Hal yang dapat memotivasinya"]!, textAlign: TextAlign.justify,),

              SizedBox(height: 16,),
              Text(
                "Hal Yang Tidak Memotivasinya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(I_manager_result["Hal yang dapat membuatnya kurang termotivasi"]!, textAlign: TextAlign.justify,),

              SizedBox(height: 16,),
              Text(
                "Lingkungan kerja yang ideal",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(I_manager_result["Lingkungan kerja yang ideal"]!, textAlign: TextAlign.justify,),
            ] else if (data["tipe"] == "Steadiness") ... [
              Text(
                "Hal Yang Memotivasinya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(S_manager_result["Hal yang dapat memotivasinya"]!, textAlign: TextAlign.justify,),

              SizedBox(height: 16,),
              Text(
                "Hal Yang Tidak Memotivasinya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(S_manager_result["Hal yang dapat membuatnya kurang termotivasi"]!, textAlign: TextAlign.justify,),

              SizedBox(height: 16,),
              Text(
                "Lingkungan kerja yang ideal",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(S_manager_result["Lingkungan kerja yang ideal"]!, textAlign: TextAlign.justify,),
            ] else if (data["tipe"] == "Compliance") ... [
              Text(
                "Hal Yang Memotivasinya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(C_manager_result["Hal yang dapat memotivasinya"]!, textAlign: TextAlign.justify,),

              SizedBox(height: 16,),
              Text(
                "Hal Yang Tidak Memotivasinya",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(C_manager_result["Hal yang dapat membuatnya kurang termotivasi"]!, textAlign: TextAlign.justify,),

              SizedBox(height: 16,),
              Text(
                "Lingkungan kerja yang ideal",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(C_manager_result["Lingkungan kerja yang ideal"]!, textAlign: TextAlign.justify,),
            ]
          ],
        ),
      ),
    );
  }

  // Helper untuk format nama field
  String _formatKey(String key) {
    return key
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ')
        .trim();
  }
}
