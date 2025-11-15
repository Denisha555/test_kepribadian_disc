import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMasukDaftar {
  Future<bool> validateLogin(String username, String password) async {
    // Implement login logic with Firebase Authentication
    QuerySnapshot data =
        await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username)
            .where('password', isEqualTo: password)
            .get();

    if (data.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> validate(dynamic value, String type) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where(type, isEqualTo: value)
        .get()
        .then((querySnapshot) {
          return querySnapshot.docs.isNotEmpty;
        });
  }

  Future<void> createAccount(
    String username,
    String password,
    String nama,
    String email,
    String umur,
    String jabatan,
    String bidang,
    String gender,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': username,
      'password': password,
      'nama': nama,
      'email': email,
      'umur': umur,
      'jabatan': jabatan,
      'bidang': bidang,
      'gender': gender,
    });
  }

  Future<String> checkJabatan(String username) async {
    try {
      print(username);
      var query =
          await FirebaseFirestore.instance
              .collection('users')
              .where("username", isEqualTo: username)
              .get();

      return query.docs.first.get('jabatan') ?? "";
    } catch (e) {
      print("checkJabatan ERROR: $e");
      return "";
    }
  }

  Future<Map<String, dynamic>?> getData(String username) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username)
            .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }
}
