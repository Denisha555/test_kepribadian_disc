import 'package:flutter/material.dart';
import 'package:aplikasi_tes_kepribadian/disc.dart';

class Quis extends StatefulWidget {
  const Quis({super.key});

  @override
  State<Quis> createState() => _QuisState();
}

class _QuisState extends State<Quis> {
  int currentIndex = 0; // soal ke berapa

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // soal selesai → pindah ke halaman hasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tes selesai! Silakan tampilkan hasil."))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> answers = questions[currentIndex];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Pilih jawaban yang paling menggambarkan diri Anda:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), 
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // 4 jawaban
              for (int i = 0; i < answers.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      // Disini nanti kamu simpan skor D/I/S/C
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(answers[i], textAlign: TextAlign.center),
                    ),
                  ),
                ),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: nextQuestion,
                child: Text("Selanjutnya"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
