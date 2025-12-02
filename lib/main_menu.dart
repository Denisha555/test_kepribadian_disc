import 'package:aplikasi_tes_kepribadian/profil.dart';
import 'package:aplikasi_tes_kepribadian/quis.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  final String username; 

  const MainMenu({super.key, required this.username});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Text(
                'Hi, ${widget.username} 👋',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ready to discover your personality?',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),

              // DISC Info Card
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade400, Colors.purple.shade400],
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
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'What is DISC?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'DISC adalah tes yang mengidentifikasi 4 tipe kepribadian utama:',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDiscType('D', 'Dominance'),
                      _buildDiscType('I', 'Influence'),
                      _buildDiscType('S', 'Steadiness'),
                      _buildDiscType('C', 'Compliance'),
                      const SizedBox(height: 12),
                      const Text(
                        'Pahami gaya komunikasi dan preferensi kerjamu untuk meningkatkan kolaborasi dan efektivitas!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Test Instructions Section
              Row(
                children: [
                  Icon(Icons.psychology_rounded, color: Colors.blue.shade600, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    "Petunjuk Pengisian Test",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Instruction Items
              _buildInstructionItem(
                number: "1",
                text: "Terdiri dari 15 pertanyaan",
                icon: Icons.quiz_outlined,
                color: Colors.purple,
              ),
              const SizedBox(height: 12),
              
              _buildInstructionItem(
                number: "2",
                text: "Pilih jawaban yang paling sesuai dengan diri Anda",
                icon: Icons.touch_app_outlined,
                color: Colors.blue,
              ),
              const SizedBox(height: 12),
              
              _buildInstructionItem(
                number: "3",
                text: "Tidak ada jawaban benar atau salah. Jawablah dengan jujur",
                icon: Icons.favorite_outline,
                color: Colors.pink,
              ),
              const SizedBox(height: 12),
              
              _buildInstructionItem(
                number: "4",
                text: "Tidak ada tipe kepribadian yang lebih baik atau lebih buruk. Semua tipe memiliki kelebihan unik",
                icon: Icons.star_outline,
                color: Colors.orange,
              ),
              const SizedBox(height: 24),

              _buildInstructionItem(
                number: "5",
                text: "Anda akan menerima ringkasan tipe dan deskripsi setelah tes selesai.",
                icon: Icons.check_circle_outline,
                color: Colors.green,
              ),

              // Start Test Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quis(username: widget.username),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: Colors.blue.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Mulai Test',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text("Disclaimer: Hasil tes ini dapat berubah sesuai kondisi Anda. Tidak ada tipe yang lebih baik atau lebih buruk; hasil hanya menunjukkan kecenderungan perilaku berdasarkan pilihan Anda.", textAlign: TextAlign.justify, style: TextStyle(fontSize: 12, color: Colors.grey.shade600),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscType(String letter, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem({
    required String number,
    required String text,
    required IconData icon,
    required MaterialColor color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: color.shade700,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Langkah $number",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color.shade700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
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