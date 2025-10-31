import 'package:flutter/material.dart';
import 'package:aplikasi_tes_kepribadian/disc.dart';

class Quis extends StatefulWidget {
  const Quis({super.key});

  @override
  State<Quis> createState() => _QuisState();
}

class _QuisState extends State<Quis> {
  int currentIndex = 0;
  int? selectedAnswerIndex;
  Map<String, int> scores = {'D': 0, 'I': 0, 'S': 0, 'C': 0};

  void selectAnswer(int index) {
    setState(() {
      selectedAnswerIndex = index;
    });
  }

  void nextQuestion() {
    if (selectedAnswerIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Pilih salah satu jawaban terlebih dahulu!", style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.grey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey.shade100, width: 5),
          ),
        ),
      );
      return;
    }

    // Simpan skor berdasarkan jawaban (D, I, S, C)
    String personality = ['D', 'I', 'S', 'C'][selectedAnswerIndex!];
    scores[personality] = scores[personality]! + 1;

    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedAnswerIndex = null; // Reset pilihan
      });
    } else {
      // Tes selesai → pindah ke halaman hasil
      Navigator.pushReplacementNamed(
        context,
        '/result',
        arguments: scores, // Kirim skor ke halaman hasil
      );
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        selectedAnswerIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> answers = questions[currentIndex];
    double progress = (currentIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Text('Keluar dari Tes?'),
                    content: const Text(
                      'Progress tes kamu akan hilang. Yakin ingin keluar?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Batal',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Keluar',
                          style: TextStyle(color: Colors.red.shade600),
                        ),
                      ),
                    ],
                  ),
            );
          },
        ),
        title: const Text(
          'DISC Personality Test',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pertanyaan ${currentIndex + 1} dari ${questions.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Question Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Question Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue.shade400,
                            Colors.purple.shade400,
                          ],
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
                          SizedBox(height: 30),
                          const Text(
                            "Pilih pernyataan yang paling menggambarkan diri Anda:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Answer Options
                    for (int i = 0; i < answers.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: InkWell(
                          onTap: () => selectAnswer(i),
                          borderRadius: BorderRadius.circular(16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  selectedAnswerIndex == i
                                      ? Colors.blue.shade600
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                    selectedAnswerIndex == i
                                        ? Colors.blue.shade600
                                        : Colors.grey.shade300,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      selectedAnswerIndex == i
                                          ? Colors.blue.shade200.withOpacity(
                                            0.5,
                                          )
                                          : Colors.grey.shade200,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          selectedAnswerIndex == i
                                              ? Colors.white
                                              : Colors.grey.shade400,
                                      width: 2,
                                    ),
                                    color:
                                        selectedAnswerIndex == i
                                            ? Colors.white
                                            : Colors.transparent,
                                  ),
                                  child:
                                      selectedAnswerIndex == i
                                          ? Center(
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue.shade600,
                                              ),
                                            ),
                                          )
                                          : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    answers[i],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color:
                                          selectedAnswerIndex == i
                                              ? Colors.white
                                              : Colors.black87,
                                      fontWeight:
                                          selectedAnswerIndex == i
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (currentIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: previousQuestion,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade600,
                        side: BorderSide(color: Colors.blue.shade600, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Sebelumnya',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (currentIndex > 0) const SizedBox(width: 12),
                Expanded(
                  flex: currentIndex > 0 ? 1 : 1,
                  child: ElevatedButton(
                    onPressed: nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      currentIndex < questions.length - 1
                          ? 'Selanjutnya'
                          : 'Selesai',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
