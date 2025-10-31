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

const D_result = {
  "Gaya bekerja": "Berorientasi pada pemecahan masalah, suka mempertanyakan keadaan yang ada, berani menerima tantangan, cepat dalam mengambil keputusan, tegas dalam memberi perintah, aktif bertindak, ingin melihat hasil dengan segera, dan mampu mengatasi kesulitan.",
  "Hal-hal yang dianggap penting": "Menikmati kekuasaan, mampu melakukan terobosan dan perubahan, ingin kemampuan serta wawasannya diakui, menyukai lingkungan yang bebas tanpa banyak batasan, ingin memiliki kesempatan untuk mandiri dan memimpin, menyukai inovasi serta variasi, memiliki jiwa kepemimpinan dan tindakan yang kuat, dan tidak suka diawasi secara ketat.",
  "Rekan kerja yang dibutuhkan": "Orang yang mampu menilai risiko dengan baik, cermat dalam menghitung untung dan rugi, berhati-hati dalam mengambil keputusan, memiliki kemampuan perencanaan dan koordinasi yang kuat, peka terhadap perasaan orang lain, mampu menyemangati orang lain melewati kata-kata, serta tidak memiliki ambisi yang berlebihan.",
};

const I_result = {
  "Gaya bekerja": "Suka bergaul dan pandai meyakinkan orang lain, mampu menciptakan suasana yang hidup dan menyenangkan, dapat membangkitkan semangat orang di sekitarnya, berpikiran luwes dan penuh ide, menyukai kebebasan dan tidak suka dibatasi, optimis, emosional, serta mudah didekati.",
  "Hal-hal yang dianggap penting": "Diterima dan disukai oleh banyak orang, kemampuan diakui oleh lingkungan, dapat menyalurkan kemampuan berbicara dengan baik, menikmati kegiatan yang melibatkan banyak orang serta interaksi sosial yang beragam, tidak terpaku pada detail dan angka, menyukai kebebasan tanpa terlalu banyak batasan, serta memiliki kebutuhan yang kuat untuk merasa dibutuhkan oleh tim.",
  "Rekan kerja yang dibutuhkan": "Orang yang dapat berbicara langsung pada inti permasalahan, memberikan komentar berdasarkan fakta, mampu mengumpulkan informasi secara objektif, tidak mudah teralihkan oleh hal-hal kecil, memiliki cara berpikir yang logis, konsisten dan tekun dalam menyelesaikan tugas, memiliki kemampuan manajemen diri yang baik, serta tidak memiliki prasangka terhadap orang lain.",
};

const S_result = {
  "Gaya bekerja": "Berhati-hati dalam membuat keputusan, memiliki loyalitas yang tinggi, berusaha menghindari konflik, fokus pada tugas dengan ketekunan yang konsisten, pandai mendengarkan dan menenangkan orang lain, bekerja secara teratur dan sistematis, mengejar konsistensi, serta senang memberikan bantuan kepada orang lain.",
  "Hal-hal yang dianggap penting": "Lingkungan yang stabil dan terjamin, pekerjaan yang berjalan sesuai rencana, memiliki waktu yang cukup untuk berpikir, hasil kerja yang diakui dan dihargai, mendapatkan ucapan terima kasih yang tulus, dapat menyeimbangkan antara pekerjaan dan kehidupan keluarga, membangun hubungan yang erat dengan kelompok, serta adanya prosedur kerja yang terstandar.",
  "Rekan kerja yang dibutuhkan": "Orang yang memiliki kemampuan beradaptasi dengan cepat, dapat menerima situasi yang tidak terduga, berani mencoba hal baru dan melakukan perubahan, mampu menangani beberapa hal sekaligus, tahu cara menolak dengan tepat, tidak terlalu memikirkan penilaian orang lain, mampu menunjukkan keunggulan pribadi, serta dapat dengan percaya diri berhadapan dengan banyak orang.",
};

const C_result = {
  "Gaya bekerja": "Pandai menganalisis dan berpikir secara logis, gemar mengumpulkan data dan informasi, sangat memperhatikan prosedur serta aturan, memiliki standar tinggi dan kecenderungan perfeksionis, disiplin serta bertanggung jawab, berpikir kritis, dan selalu memiliki kesadaran tinggi terhadap potensi risiko atau masalah yang mungkin terjadi.",
  "Hal-hal yang dianggap penting": "Kualitas dan ketepatan dalam pekerjaan, adanya peraturan dan sistem yang jelas, ketersediaan waktu untuk berpikir secara mendalam, lingkungan kerja dengan tuntutan yang konkret, pedoman perilaku yang terstruktur, penampilan profesional yang berorientasi pada pengetahuan, serta ruang untuk berpikir dan bertindak secara mandiri.",
  "Rekan kerja yang dibutuhkan": "Orang yang memiliki kemampuan mengambil keputusan dengan cepat, mampu menggunakan cara yang efisien dan hemat waktu, terbuka dalam mengungkapkan kepedulian serta rasa terima kasih, dapat beradaptasi dengan perubahan dan memanfaatkan kebijakan secara fleksibel, berani menyampaikan pendapat dengan jujur, aktif berpartisipasi dalam kerja tim, serta mampu berdiskusi secara menyeluruh hingga mencapai kesepakatan bersama.",
};