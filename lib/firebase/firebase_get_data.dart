import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseGetData {
  Future<List<Map<String, dynamic>>> getEmployee(String bidang) async {
    List<Map<String, dynamic>> employees = [];

    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where("bidang", isEqualTo: bidang)
            .where("jabatan", isEqualTo: "Karyawan")
            .get();

    for (var doc in querySnapshot.docs) {
      employees.add(doc.data());
    }
    return employees;
  }
}
