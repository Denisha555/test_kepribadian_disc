const D = [
  "Suka mengendalikan lingkungan",
  "Merasa puas saat berhasil menggerakkan orang orang di sekitarnya",
  "Merasa senang saat diberikan kesempatan untuk membuat keputusan dan menyelesaikan masalah",
  "Menyukai tantangan",
  "Menyukai sesuatu yang revolusioner",
  "Suka membuat visi visi",
  "Kurang menyukai sesuatu yang terlalu detail",
  "Berbicara terus terang",
  "Punya rasa percaya diri yang kuat"
];

const I = [
  "Menyukai aktivitas yang memungkinkan bertemu banyak orang",
  "Suka mengekspresikan diri",
  "Memiliki rasa empati yang tinggi",
  "Merupakan orang yang optimis, penuh antusiasme dan riang",
  "Kurangnya ketelitian",
  "Memiliki pertemanan yang luas",
  "Menyukai kerja tim",
  "Berharap mendapat pengakuan dari orang lain",
  "Ceria dan optimis"
];

const S = [
  "Tidak terlalu suka perubahan",
  "Suka mengerjakan sesuatu secara sistematis, bertahap dan teratur",
  "Dapat diandalkan",
  "Pendiam",
  "Cenderung sabar, dapat diandalkan, serta loyal",
  "Terkesan membosankan",
  "Suka bekerja di lingkungan yang penuh dengan rutinitas tanpa perubahan berarti",
  "Sulit mengambil keputusan",
  "Baik dalam mendengarkan orang lain"
];

const C = [
  "Menyukai akurasi dan ketelitian",
  "Suka merencanakan sesuatu secara detail, menyeluruh dan matang",
  "Suka melakukan analisa",
  "Biasanya terpaku pada suatu prosedur yang jelas",
  "Berusaha menelaah dan bersikap skeptis saat terjadi perubahan atau hal baru",
  "Cenderung kritis pada suatu hal",
  "Perfeksionis",
  "Takut akan kritik",
  "Memiliki standar yang tinggi"
];

// randomize jawaban untuk setiap pertanyaan
final List<List<String>> questions = List.generate(
  D.length,
  (index) {
    List<String> answers = [
      D[index],
      I[index],
      S[index],
      C[index],
    ];
    answers.shuffle();
    return answers;
  },
);