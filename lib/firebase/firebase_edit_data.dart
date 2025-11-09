import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEditData {
  Future<void> updateTipe(String username, String tipe) async {
    final query =
        await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username)
            .limit(1)
            .get();

    if (query.docs.isNotEmpty) {
      await query.docs.first.reference.update({
        'tipe': FieldValue.arrayUnion([{
          "hasil": tipe,
          "tanggal": DateTime.now().toString(),
        }]),
      });
    }
  }

  Future<void> updateData(String username, String value, String key) async {
    final query =
        await FirebaseFirestore.instance
            .collection('users')
            .where("username", isEqualTo: username)
            .get();

    if (query.docs.isNotEmpty) {
      await query.docs.first.reference.set({
        key: value,
      }, SetOptions(merge: true));
    }
  }
}
