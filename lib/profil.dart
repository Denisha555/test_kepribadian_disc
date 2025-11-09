import 'package:aplikasi_tes_kepribadian/disc.dart';
import 'package:aplikasi_tes_kepribadian/firebase/firebase_edit_data.dart';
import 'package:aplikasi_tes_kepribadian/firebase/firebase_masuk_daftar.dart';
import 'package:aplikasi_tes_kepribadian/main.dart';
import 'package:flutter/material.dart';
import 'disc.dart';

class Profil extends StatefulWidget {
  final String username;

  const Profil({super.key, required this.username});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _namaLengkapController = TextEditingController();
  final _emailController = TextEditingController();
  final _umurController = TextEditingController();

  final List<String> _bidangList = [
    'IT',
    'HR',
    'Finance',
    'Marketing',
    'Sales',
  ];
  final List<String> _genderList = ['Female', 'Male'];

  bool _isEditing = false;

  Map<String, dynamic>? userData = {};
  String? _tipe = '';
  String? _bidang = '';
  String? _gender = '';
  int? _jumlahTes = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _emailController.dispose();
    _umurController.dispose();
    super.dispose();
  }

  void loadData() async {
    userData = await FirebaseMasukDaftar().getData(widget.username);
    final tipeList = userData?["tipe"];

    if (tipeList is List && tipeList.isNotEmpty) {
      _tipe = tipeList.last["hasil"] ?? "";
      _jumlahTes = tipeList.length;
    } else {
      _tipe = "";
      _jumlahTes = 0;
    }

    if (userData != null) {
      setState(() {
        _namaLengkapController.text = userData!["nama"];
        _emailController.text = userData!["email"];
        _umurController.text = userData!["umur"];
        _gender = userData!["gender"];
        _bidang = userData!["bidang"];
        _tipe = _tipe;
        _jumlahTes = _jumlahTes;
      });
    }
  }

  void _saveData() async {
    try {
      await FirebaseEditData().updateData(
        widget.username,
        _namaLengkapController.text,
        "nama",
      );
      await FirebaseEditData().updateData(
        widget.username,
        _emailController.text,
        "email",
      );
      await FirebaseEditData().updateData(
        widget.username,
        _umurController.text,
        "umur",
      );
      await FirebaseEditData().updateData(widget.username, _bidang!, "bidang", );
      await FirebaseEditData().updateData(widget.username, _gender!, "gender", );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('Data berhasil disimpan'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 12),
              Expanded(child: Text('Gagal menyimpan data: $e')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
    }
  }

  Color _getDiscColor(String? tipe) {
    if (tipe == null || tipe.isEmpty) return Colors.grey;
    switch (tipe[0].toUpperCase()) {
      case 'D':
        return Colors.red.shade400;
      case 'I':
        return Colors.orange.shade400;
      case 'S':
        return Colors.green.shade400;
      case 'C':
        return Colors.blue.shade400;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade600, Colors.purple.shade500],
            ),
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _isEditing ? Icons.check : Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (_isEditing) {
                    _saveData();
                  }
                  _isEditing = !_isEditing;
                });
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section dengan Avatar
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade600, Colors.purple.shade500],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.username,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),

            // Stats Cards
            Transform.translate(
              offset: Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_tipe == 'Dominance' ||
                              _tipe == 'Influence' ||
                              _tipe == 'Steadiness' ||
                              _tipe == 'Compliance') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailTipe(tipe: _tipe!),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: _getDiscColor(_tipe).withOpacity(0.3),
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Tipe DISC',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 12),
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _getDiscColor(_tipe),
                                      _getDiscColor(_tipe).withOpacity(0.7),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _getDiscColor(
                                        _tipe,
                                      ).withOpacity(0.4),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    _tipe == '' || _tipe == null
                                        ? '-'
                                        : _tipe![0],
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.shade200.withOpacity(0.5),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Jumlah Tes',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.purple.shade400,
                                    Colors.purple.shade600,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple.shade300.withOpacity(
                                      0.5,
                                    ),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  _jumlahTes.toString(),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Form Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Informasi Pribadi'),
                  SizedBox(height: 20),

                  _buildInputField(
                    controller: _namaLengkapController,
                    label: 'Nama Lengkap',
                    icon: Icons.person_outline,
                    enabled: _isEditing,
                  ),
                  SizedBox(height: 16),

                  _buildInputField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    enabled: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),

                  _buildInputField(
                    controller: _umurController,
                    label: 'Umur',
                    icon: Icons.calendar_today,
                    enabled: _isEditing,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),

                  _buildDropdownField(
                    items: _genderList,
                    enabled: _isEditing,
                    icon: Icons.wc_rounded,
                    label: "Gender",
                    value: _gender,
                    onChanged: (newValue) {
                      setState(() {
                        _gender = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 16),

                  _buildDropdownField(
                    items: _bidangList,
                    label: "Bidang",
                    enabled: _isEditing,
                    icon: Icons.work_outline_rounded,
                    value: _bidang,
                    onChanged: (newValue) {
                      setState(() {
                        _bidang = newValue;
                      });
                    },
                  ),

                  SizedBox(height: 32),

                  // Logout Button
                  Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text(
                                'Konfirmasi Logout',
                                style: TextStyle(fontSize: 18),
                              ),
                              content: Text(
                                'Apakah Anda yakin ingin logout?',
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Batal',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.red.shade400, Colors.red.shade600],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.shade300.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout_rounded, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
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
          width: 5,
          height: 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade600, Colors.purple.shade500],
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required List<String> items,
    required bool enabled,
    required IconData icon,
    required String label,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                enabled
                    ? Colors.blue.shade100.withOpacity(0.5)
                    : Colors.grey.shade200,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value:
            (value != null && value.isNotEmpty && items.contains(value))
                ? value
                : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: enabled ? Colors.blue.shade600 : Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            icon,
            color: enabled ? Colors.blue.shade600 : Colors.grey.shade400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade50,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
        hint: Text(
          'Pilih $label',
          style: TextStyle(color: Colors.grey.shade400),
        ),
        items:
            items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
        onChanged: enabled ? onChanged : null,
      ),
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                enabled
                    ? Colors.blue.shade100.withOpacity(0.5)
                    : Colors.grey.shade200,
            blurRadius: 10,
            offset: Offset(0, 4),
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
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: enabled ? Colors.blue.shade600 : Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            icon,
            color: enabled ? Colors.blue.shade600 : Colors.grey.shade400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade50,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}

class DetailTipe extends StatefulWidget {
  final String tipe;

  const DetailTipe({super.key, required this.tipe});

  @override
  State<DetailTipe> createState() => _DetailTipeState();
}

class _DetailTipeState extends State<DetailTipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Tipe")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tipe DISC: ${widget.tipe}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              if (widget.tipe == "Dominance") ...[
                Text(
                  "Gaya bekerja",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  D_user_result["Gaya bekerja"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Hal yang dianggap penting",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  D_user_result["Hal-hal yang dianggap penting"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Rekan kerja yang dibutuhkan",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  D_user_result["Rekan kerja yang dibutuhkan"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Saran",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  D_user_result["Saran"].toString(),
                  textAlign: TextAlign.justify,
                ),
              ] else if (widget.tipe == "Influence") ...[
                Text(
                  "Gaya bekerja",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  I_user_result["Gaya bekerja"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Hal yang dianggap penting",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  I_user_result["Hal-hal yang dianggap penting"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Rekan kerja yang dibutuhkan",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  I_user_result["Rekan kerja yang dibutuhkan"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Saran",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  I_user_result["Saran"].toString(),
                  textAlign: TextAlign.justify,
                ),
              ] else if (widget.tipe == "Steadiness") ...[
                Text(
                  "Gaya bekerja",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  S_user_result["Gaya bekerja"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Hal yang dianggap penting",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  S_user_result["Hal-hal yang dianggap penting"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Rekan kerja yang dibutuhkan",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  S_user_result["Rekan kerja yang dibutuhkan"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Saran",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  S_user_result["Saran"].toString(),
                  textAlign: TextAlign.justify,
                ),
              ] else if (widget.tipe == "Compliance") ...[
                Text(
                  "Gaya bekerja",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  C_user_result["Gaya bekerja"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Hal yang dianggap penting",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  C_user_result["Hal-hal yang dianggap penting"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Rekan kerja yang dibutuhkan",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  C_user_result["Rekan kerja yang dibutuhkan"].toString(),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 16),

                Text(
                  "Saran",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  C_user_result["Saran"].toString(),
                  textAlign: TextAlign.justify,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
