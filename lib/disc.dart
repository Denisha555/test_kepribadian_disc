const D = [
  "Suka mengendalikan lingkungan",
  "Merasa puas saat berhasil menggerakkan orang-orang di sekitar",
  "Merasa senang saat diberikan kesempatan untuk membuat keputusan dan menyelesaikan masalah",
  "Menyukai tantangan",
  "Menyukai sesuatu yang revolusioner",
  "Suka membuat visi- visi",
  "Kurang menyukai sesuatu yang terlalu detail",
  "Berbicara terus terang",
  "Punya rasa percaya diri yang kuat",
  "Memiliki motivasi yang kuat untuk meraih kesuksesan",
  "Mampu memotivasi orang lain",
  "Mudah menjaga jarak dengan orang lain",
  "Sangat menginginkan kemandirian serta kebebasan",
  "Orang yang berkemauan kuat, cenderung memiliki ketangguhan dan kemandirian",
  "Tidak suka diatur atau diarahkan orang lain",
];

const I = [
  "Menyukai aktivitas yang memungkinkan bertemu banyak orang",
  "Suka mengekspresikan diri",
  "Memiliki rasa empati yang tinggi",
  "Merupakan orang penuh antusiasme dan riang",
  "Kurangnya ketelitian",
  "Memiliki pertemanan yang luas",
  "Menyukai kerja tim",
  "Berharap mendapat pengakuan dari orang lain",
  "Ceria dan optimis",
  "Memiliki kemampuan komunikasi dan persuasi yang baik",
  "Bergerak dengan ritme yang cepat",
  "Cenderung hanya mendengarkan bagian yang ingin didengar",
  "Memiliki keinginan yang kuat untuk memengaruhi dan memberi pengaruh pada orang lain",
  "Suka mengikuti tren-tren baru",
  "Kurang terampil dalam membuat persiapan dan perencanaan",
];

const S = [
  "Tidak terlalu suka perubahan",
  "Suka mengerjakan sesuatu secara sistematis, bertahap dan teratur",
  "Dapat diandalkan",
  "Pendiam",
  "Cenderung sabar serta loyal",
  "Terkesan membosankan",
  "Suka bekerja di lingkungan yang penuh dengan rutinitas tanpa perubahan berarti",
  "Sulit mengambil keputusan",
  "Baik dalam mendengarkan orang lain",
  "Peduli terhadap orang lain",
  "Melakukan sesuatu dengan perlahan dan hati-hati",
  "Bersifat sangat ramah",
  "Lebih menyukai untuk mengerjakan satu hal dalam satu waktu",
  "Sulit untuk menolak permintaan orang lain",
  "Sulit untuk berbicara di depan umum atau orang banyak",
];

const C = [
  "Menyukai akurasi dan ketelitian",
  "Suka merencanakan sesuatu secara detail, menyeluruh dan matang",
  "Suka melakukan analisa",
  "Cenderung terpaku pada suatu prosedur yang jelas",
  "Berusaha menelaah dan bersikap skeptis saat terjadi perubahan atau hal baru",
  "Cenderung kritis pada suatu hal",
  "Perfeksionis",
  "Takut akan kritik",
  "Memiliki standar yang tinggi",
  "Cenderung serius dan rasional",
  "Cenderung tidak banyak berbicara",
  "Sulit menyesuaikan diri dalam situasi tertentu",
  "Cenderung berhati-hati dan selalu berpikir matang sebelum bertindak",
  "Cenderung terlalu fokus pada hal-hal kecil sehingga mengabaikan hal yang lebih penting",
  "Kurang terampil dalam menjalin hubungan dengan orang lain",
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


const D_user_result = {
  "Gaya bekerja": "Berorientasi pada pemecahan masalah, suka mempertanyakan keadaan yang ada, berani menerima tantangan, cepat dalam mengambil keputusan, tegas dalam memberi perintah, aktif bertindak, ingin melihat hasil dengan segera, dan mampu mengatasi kesulitan.",
  "Hal-hal yang dianggap penting": "Menikmati kekuasaan, mampu melakukan terobosan dan perubahan, ingin kemampuan serta wawasannya diakui, menyukai lingkungan yang bebas tanpa banyak batasan, ingin memiliki kesempatan untuk mandiri dan memimpin, menyukai inovasi serta variasi, memiliki jiwa kepemimpinan dan tindakan yang kuat, dan tidak suka diawasi secara ketat.",
  "Rekan kerja yang dibutuhkan": "Orang yang mampu menilai risiko dengan baik, cermat dalam menghitung untung dan rugi, berhati-hati dalam mengambil keputusan, memiliki kemampuan perencanaan dan koordinasi yang kuat, peka terhadap perasaan orang lain, mampu menyemangati orang lain melewati kata-kata, serta tidak memiliki ambisi yang berlebihan.",
  "Saran": "Perlu disadari bahwa manusia dan hubungan antarpersonal sama pentingnya dengan hasil yang dicapai. Selain itu, penting juga untuk memahami bahwa beristirahat dan bersantai bukanlah hal yang salah, selama dilakukan secara seimbang. Dalam bekerja maupun dalam kehidupan, beberapa bentuk aturan tetap dibutuhkan. Kita juga perlu menyadari bahwa setiap orang memiliki atasan atau pihak yang harus dihormati dalam sebuah struktur. Menjelaskan alasan atau latar belakang suatu keputusan akan membantu orang lain memahami dan menerima keputusan tersebut dengan lebih baik.",
};

const I_user_result = {
  "Gaya bekerja": "Suka bergaul dan pandai meyakinkan orang lain, mampu menciptakan suasana yang hidup dan menyenangkan, dapat membangkitkan semangat orang di sekitarnya, berpikiran luwes dan penuh ide, menyukai kebebasan dan tidak suka dibatasi, optimis, emosional, serta mudah didekati.",
  "Hal-hal yang dianggap penting": "Diterima dan disukai oleh banyak orang, kemampuan diakui oleh lingkungan, dapat menyalurkan kemampuan berbicara dengan baik, menikmati kegiatan yang melibatkan banyak orang serta interaksi sosial yang beragam, tidak terpaku pada detail dan angka, menyukai kebebasan tanpa terlalu banyak batasan, serta memiliki kebutuhan yang kuat untuk merasa dibutuhkan oleh tim.",
  "Rekan kerja yang dibutuhkan": "Orang yang dapat berbicara langsung pada inti permasalahan, memberikan komentar berdasarkan fakta, mampu mengumpulkan informasi secara objektif, tidak mudah teralihkan oleh hal-hal kecil, memiliki cara berpikir yang logis, konsisten dan tekun dalam menyelesaikan tugas, memiliki kemampuan manajemen diri yang baik, serta tidak memiliki prasangka terhadap orang lain.",
  "Saran": "Perlu menyadari pentingnya pengelolaan waktu dan belajar menerapkannya dengan baik dalam aktivitas sehari-hari. Selain itu, perlu memahami bahwa sikap terlalu optimis dapat memberikan dampak yang kurang menguntungkan dalam situasi tertentu. Kemampuan untuk mendengarkan juga merupakan hal yang sangat penting. Setiap tugas hendaknya diselesaikan hingga tuntas, dan rasa tanggung jawab harus selalu dijaga.",
};

const S_user_result = {
  "Gaya bekerja": "Berhati-hati dalam membuat keputusan, memiliki loyalitas yang tinggi, berusaha menghindari konflik, fokus pada tugas dengan ketekunan yang konsisten, pandai mendengarkan dan menenangkan orang lain, bekerja secara teratur dan sistematis, mengejar konsistensi, serta senang memberikan bantuan kepada orang lain.",
  "Hal-hal yang dianggap penting": "Lingkungan yang stabil dan terjamin, pekerjaan yang berjalan sesuai rencana, memiliki waktu yang cukup untuk berpikir, hasil kerja yang diakui dan dihargai, mendapatkan ucapan terima kasih yang tulus, dapat menyeimbangkan antara pekerjaan dan kehidupan keluarga, membangun hubungan yang erat dengan kelompok, serta adanya prosedur kerja yang terstandar.",
  "Rekan kerja yang dibutuhkan": "Orang yang memiliki kemampuan beradaptasi dengan cepat, dapat menerima situasi yang tidak terduga, berani mencoba hal baru dan melakukan perubahan, mampu menangani beberapa hal sekaligus, tahu cara menolak dengan tepat, tidak terlalu memikirkan penilaian orang lain, mampu menunjukkan keunggulan pribadi, serta dapat dengan percaya diri berhadapan dengan banyak orang.",
  "Saran": "Perlu menyadari bahwa perubahan dapat membuka peluang baru. Selain itu, penting untuk memahami bahwa persahabatan saja tidak selalu dapat menjadi dasar dalam setiap keputusan. Memiliki batasan diri justru dapat membawa kebaikan. Mengatakan “tidak” ketika memang diperlukan bukanlah hal yang salah. Seseorang yang memiliki sifat melayani orang lain tetap dapat memiliki pendirian dan pemikiran sendiri.",
};

const C_user_result = {
  "Gaya bekerja": "Pandai menganalisis dan berpikir secara logis, gemar mengumpulkan data dan informasi, sangat memperhatikan prosedur serta aturan, memiliki standar tinggi dan kecenderungan perfeksionis, disiplin serta bertanggung jawab, berpikir kritis, dan selalu memiliki kesadaran tinggi terhadap potensi risiko atau masalah yang mungkin terjadi.",
  "Hal-hal yang dianggap penting": "Kualitas dan ketepatan dalam pekerjaan, adanya peraturan dan sistem yang jelas, ketersediaan waktu untuk berpikir secara mendalam, lingkungan kerja dengan tuntutan yang konkret, pedoman perilaku yang terstruktur, penampilan profesional yang berorientasi pada pengetahuan, serta ruang untuk berpikir dan bertindak secara mandiri.",
  "Rekan kerja yang dibutuhkan": "Orang yang memiliki kemampuan mengambil keputusan dengan cepat, mampu menggunakan cara yang efisien dan hemat waktu, terbuka dalam mengungkapkan kepedulian serta rasa terima kasih, dapat beradaptasi dengan perubahan dan memanfaatkan kebijakan secara fleksibel, berani menyampaikan pendapat dengan jujur, aktif berpartisipasi dalam kerja tim, serta mampu berdiskusi secara menyeluruh hingga mencapai kesepakatan bersama.",
  "Saran": "Perlu dipahami bahwa tidak selalu dibutuhkan dukungan dari semua orang dalam setiap situasi. Penjelasan secara lengkap juga tidak selalu mungkin diberikan pada setiap waktu. Tenggat waktu tetap harus dihormati dan dipatuhi. Mengambil risiko yang telah dianalisis dengan matang dapat membawa manfaat. Selain itu, perlu disadari bahwa standar mengenai keunggulan dan pencapaian dapat berbeda-beda pada setiap orang maupun situasi.",
};


const D_manager_result = {
  "Hal yang dapat memotivasinya": "Ia akan termotivasi ketika diberikan kendali atas lingkungan kerjanya, kepercayaan untuk mengarahkan pekerjaan orang lain, serta kesempatan menghadapi tantangan baru dan berkembang menuju posisi yang lebih tinggi.",
  "Hal yang dapat membuatnya kurang termotivasi": "Ia akan merasa kurang termotivasi ketika keputusannya dipertanyakan atau dibatalkan, ketika tanggung jawabnya terhadap hasil dibatasi, akses terhadap sumber daya yang diperlukan terhambat, atau ketika ia diawasi terlalu ketat.",
  "Lingkungan kerja yang ideal": "Lingkungan kerja yang paling sesuai adalah lingkungan yang memberikan kebebasan sebesar mungkin untuk menentukan cara bekerja, dengan ritme yang cepat dan berorientasi pada hasil.",
};

const I_manager_result = {
  "Hal yang dapat memotivasinya": "Ia akan merasa lebih bersemangat ketika dapat berdialog dengan orang lain, menerima umpan balik secara langsung, mendapatkan pengakuan yang antusias, serta ketika perasaannya dihargai dan diakui.",
  "Hal yang dapat membuatnya kurang termotivasi": "Ia cenderung kurang termotivasi ketika berada di lingkungan dengan rekan kerja yang tertutup atau kurang ramah, jadwal yang terlalu kaku, suasana yang pesimis, atau ketika harus menghadapi tugas yang sifatnya rutin dan sangat detail.",
  "Lingkungan kerja yang ideal": "Lingkungan kerja yang paling sesuai adalah lingkungan dengan ritme yang cepat, memberikan umpan balik serta pengakuan secara positif, dan menawarkan variasi serta ruang untuk berkreasi.",
};

const S_manager_result = {
  "Hal yang dapat memotivasinya": "Ia akan merasa lebih termotivasi ketika dapat bekerja sama dengan orang lain, memiliki tanggung jawab dan wewenang yang jelas, dapat memberikan pelayanan yang baik, serta merasa memiliki keamanan dalam pekerjaannya.",
  "Hal yang dapat membuatnya kurang termotivasi": "Ia cenderung kurang bersemangat ketika menghadapi perubahan yang cepat dan tidak terduga, suasana kerja yang terlalu kompetitif dan agresif, kurangnya dukungan dari atasan maupun rekan kerja, atau ketika harus berhadapan dengan konfrontasi langsung.",
  "Lingkungan kerja yang ideal": "Lingkungan kerja yang cocok baginya adalah lingkungan yang teratur dan dapat diprediksi, serta suasana yang harmonis, informal, dan bersahabat.",
};

const C_manager_result = {
  "Hal yang dapat memotivasinya": "Ia akan lebih termotivasi ketika dapat bekerja dengan cara yang logis dan sistematis, memiliki kesempatan untuk memastikan hasil yang akurat dan berkualitas, serta menerima umpan balik yang spesifik tentang pekerjaannya.",
  "Hal yang dapat membuatnya kurang termotivasi": "Ia cenderung kurang bersemangat ketika aturan atau ekspektasi sering berubah, ketika tidak memiliki cukup waktu untuk menganalisis informasi, ketika harus bersosialisasi secara terpaksa, atau ketika tidak ada standar kualitas yang jelas dalam pekerjaan.",
  "Lingkungan kerja yang ideal": "Lingkungan kerja yang paling sesuai baginya adalah lingkungan yang memberikan waktu dan sumber daya yang memadai untuk mencapai standar kualitas yang diharapkan, serta suasana kerja yang tenang, profesional, dan berfokus pada tugas.",
};