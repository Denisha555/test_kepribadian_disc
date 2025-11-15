import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi_tes_kepribadian/disc.dart';

class FirebaseForwardChaining {
  Future<void> uploadCiri() async {
    final firestore = FirebaseFirestore.instance;

    final allData = [
      {'label': 'D', 'list': D},
      {'label': 'I', 'list': I},
      {'label': 'S', 'list': S},
      {'label': 'C', 'list': C},
    ];

    int counter = 1;

    for (final group in allData) {
      final label = group['label'] as String;
      final list = group['list'] as List<String>;

      for (final text in list) {
        final docId = 'C$counter';
        await firestore.collection('ciri').doc(docId).set({
          'keterangan': text,
          'label': label,
        });
        print('Uploaded: $docId ($label)');
        counter++;
      }
    }
  }

  Future<void> uploadKepribadian() async {
    final firestore = FirebaseFirestore.instance;

    final data = ["Dominance", "Influence", "Steadiness", "Compliance"];

    int counter = 1;

    for (final text in data) {
      final docId = 'K$counter';
      await firestore.collection('kepribadian').doc(docId).set({
        'keterangan': text,
      });
      counter++;
    }
  }

  Future<void> uploadRule() async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('rule').doc('R1').set({
      'kondisi': 'D>=I && D>=S && D>=C',
      'hasil': 'D',
    });

    await firestore.collection('rule').doc('R2').set({
      'kondisi': 'I>=D && I>=S && I>=C',
      'hasil': 'I',
    });

    await firestore.collection('rule').doc('R3').set({
      'kondisi': 'S>=D && S>=I && S>=C',
      'hasil': 'S',
    });

    await firestore.collection('rule').doc('R4').set({
      'kondisi': 'C>=D && C>=I && C>=S',
      'hasil': 'C',
    });
  }

  Future<void> uploadHasilKaryawan() async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('hasil_karyawan').doc('H1').set({
      'kepribadian': 'K1',
      "Gaya Bekerja": D_user_result["Gaya Bekerja"],
      "Hal-hal yang dianggap penting":
          D_user_result["Hal-hal yang dianggap penting"],
      "Rekan kerja yang dibutuhkan":
          D_user_result["Rekan kerja yang dibutuhkan"],
      "Saran": D_user_result["Saran"],
    });

    await firestore.collection('hasil_karyawan').doc('H2').set({
      'kepribadian': 'K2',
      "Gaya Bekerja": I_user_result["Gaya Bekerja"],
      "Hal-hal yang dianggap penting":
          I_user_result["Hal-hal yang dianggap penting"],
      "Rekan kerja yang dibutuhkan":
          I_user_result["Rekan kerja yang dibutuhkan"],
      "Saran": I_user_result["Saran"],
    });

    await firestore.collection('hasil_karyawan').doc('H3').set({
      'kepribadian': 'K3',
      "Gaya Bekerja": S_user_result["Gaya Bekerja"],
      "Hal-hal yang dianggap penting":
          S_user_result["Hal-hal yang dianggap penting"],
      "Rekan kerja yang dibutuhkan":
          S_user_result["Rekan kerja yang dibutuhkan"],
      "Saran": S_user_result["Saran"],
    });

    await firestore.collection('hasil_karyawan').doc('H4').set({
      'kepribadian': 'K4',
      "Gaya Bekerja": C_user_result["Gaya Bekerja"],
      "Hal-hal yang dianggap penting":
          C_user_result["Hal-hal yang dianggap penting"],
      "Rekan kerja yang dibutuhkan":
          C_user_result["Rekan kerja yang dibutuhkan"],
      "Saran": C_user_result["Saran"],
    });
  }

  Future<void> uploadHasilManager() async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('hasil_manager').doc('H1').set({
      'kepribadian': 'K1',
      "Hal yang dapat memotivasinya":
          D_manager_result["Hal yang dapat memotivasinya"],
      "Hal yang dapat membuatnya kurang termotivasi":
          D_manager_result["Hal yang dapat membuatnya kurang termotivasi"],
      "Lingkungan kerja yang ideal":
          D_manager_result["Lingkungan kerja yang ideal"],
    });

    await firestore.collection('hasil_manager').doc('H2').set({
      'kepribadian': 'K2',
      "Hal yang dapat memotivasinya":
          I_manager_result["Hal yang dapat memotivasinya"],
      "Hal yang dapat membuatnya kurang termotivasi":
          I_manager_result["Hal yang dapat membuatnya kurang termotivasi"],
      "Lingkungan kerja yang ideal":
          I_manager_result["Lingkungan kerja yang ideal"],
    });

    await firestore.collection('hasil_manager').doc('H3').set({
      'kepribadian': 'K3',
      "Hal yang dapat memotivasinya":
          S_manager_result["Hal yang dapat memotivasinya"],
      "Hal yang dapat membuatnya kurang termotivasi":
          S_manager_result["Hal yang dapat membuatnya kurang termotivasi"],
      "Lingkungan kerja yang ideal":
          S_manager_result["Lingkungan kerja yang ideal"],
    });

    await firestore.collection('hasil_manager').doc('H4').set({
      'kepribadian': 'K4',
      "Hal yang dapat memotivasinya":
          C_manager_result["Hal yang dapat memotivasinya"],
      "Hal yang dapat membuatnya kurang termotivasi":
          C_manager_result["Hal yang dapat membuatnya kurang termotivasi"],
    });
  }

  Future<void> uploadriwayat(String username, String nama, List fakta) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('konsultasi').doc().set({
      'username': username,
      'nama': nama,
      'tanggal': DateTime.now(),
      'fakta': fakta,
    });
  }

  Future<void> updateRiwayat(String username, String type) async {
    final firestore = FirebaseFirestore.instance;

    var snapshot = await firestore
        .collection('konsultasi')
        .where('username', isEqualTo: username)
        .orderBy('tanggal', descending: true)
        .limit(1)
        .get();

    await firestore .collection('konsultasi').doc(snapshot.docs[0].id).set({
      'hasil': type,
    }, SetOptions(merge: true));
  }

  Future<List<dynamic>> getRiwayat(String username) async {
    final firestore = FirebaseFirestore.instance;

    var snapshot =
        await firestore
            .collection('konsultasi')
            .where('username', isEqualTo: username)
            .orderBy('tanggal', descending: true)
            .limit(1)
            .get();

    // Ubah setiap dokumen ke bentuk Map<String, dynamic>
    return snapshot.docs.map((doc) => doc.data()).toList()[0]['fakta'];
  }

  Future<void> updateNilai(String username, String type, int score) async {
    final firestore = FirebaseFirestore.instance;

    var snapshot =
        await firestore
            .collection('konsultasi')
            .where('username', isEqualTo: username)
            .orderBy('tanggal', descending: true)
            .limit(1)
            .get();
    
    await firestore .collection('konsultasi').doc(snapshot.docs[0].id).set({
      type: score,
    }, SetOptions(merge: true));
  }

  Future<List<Map<String, dynamic>>> getAllCiri() async {
    final firestore = FirebaseFirestore.instance;

    var snapshot = await firestore.collection('ciri').get();

    // Ubah setiap dokumen ke bentuk Map<String, dynamic>
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> getHasilKaryawan(String type) async {
    final firestore = FirebaseFirestore.instance;

    var snapshot = await firestore.collection('hasil_karyawan').where("kepribadian", isEqualTo: type).get();
    print("hasil: ${snapshot.docs.map((doc) => doc.data()).toList()}");
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> getHasilManager(String type) async {
    final firestore = FirebaseFirestore.instance;

    var snapshot = await firestore.collection('hasil_manager').where("kepribadian", isEqualTo: type).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List <Map<String, dynamic>>> getRule() async {
    final firestore = FirebaseFirestore.instance;

    var snapshot = await firestore.collection('rule').get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
