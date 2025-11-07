import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEditData {
  Future<void> updateTipe(String username, String tipe) async {
    final query = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1) // supaya lebih cepat & hemat
        .get();

    if (query.docs.isNotEmpty) {
      await query.docs.first.reference.set({'tipe': tipe}, SetOptions(merge: true));
    }
  }
}

