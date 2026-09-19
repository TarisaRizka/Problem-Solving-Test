import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Highest Palindrome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HighestPalindromePage(),
    );
  }
}

class HighestPalindromePage extends StatefulWidget {
  const HighestPalindromePage({super.key});

  @override
  State<HighestPalindromePage> createState() => _HighestPalindromePageState();
}

class _HighestPalindromePageState extends State<HighestPalindromePage> {
  final TextEditingController stringController = TextEditingController();

  final TextEditingController kController = TextEditingController();

  String hasil = '';

  // ============================================================
  // Fungsi utama Highest Palindrome
  // ============================================================
  String highestPalindrome(String s, int k) {
    // Validasi string kosong
    if (s.isEmpty) {
      return '-1';
    }

    // Validasi apakah semua karakter adalah angka
    if (!isNumber(s, 0)) {
      return '-1';
    }

    // Mengubah String menjadi List karakter
    List<String> angka = stringToList(s, 0);

    // Tahap pertama:
    // Membuat string menjadi palindrome dengan jumlah perubahan minimum
    int perubahan = makePalindrome(
      angka,
      0,
      angka.length - 1,
    );

    // Jika perubahan yang diperlukan lebih besar dari k,
    // maka palindrome tidak dapat dibuat.
    if (perubahan > k) {
      return '-1';
    }

    // Sisa perubahan yang masih tersedia
    int sisa = k - perubahan;

    // Tahap kedua:
    // Memaksimalkan nilai palindrome
    maximizePalindrome(
      angka,
      0,
      angka.length - 1,
      sisa,
    );

    return listToString(angka, 0);
  }

  // ============================================================
  // Mengecek apakah string hanya berisi angka
  // Rekursif
  // ============================================================
  bool isNumber(String s, int index) {
    if (index >= s.length) {
      return true;
    }

    int code = s.codeUnitAt(index);

    if (code < 48 || code > 57) {
      return false;
    }

    return isNumber(s, index + 1);
  }

  // ============================================================
  // Mengubah String menjadi List<String>
  // Rekursif
  // ============================================================
  List<String> stringToList(String s, int index) {
    if (index >= s.length) {
      return [];
    }

    return [
      s[index],
      ...stringToList(s, index + 1),
    ];
  }

  // ============================================================
  // Mengubah List<String> kembali menjadi String
  // Rekursif
  // ============================================================
  String listToString(List<String> angka, int index) {
    if (index >= angka.length) {
      return '';
    }

    return angka[index] + listToString(angka, index + 1);
  }

  // ============================================================
  // Mengubah angka menjadi palindrome
  //
  // Fungsi ini mengembalikan jumlah perubahan yang diperlukan.
  // ============================================================
  int makePalindrome(
    List<String> angka,
    int kiri,
    int kanan,
  ) {
    // Base case
    if (kiri >= kanan) {
      return 0;
    }

    // Jika kedua angka sama,
    // tidak membutuhkan perubahan.
    if (angka[kiri] == angka[kanan]) {
      return makePalindrome(
        angka,
        kiri + 1,
        kanan - 1,
      );
    }

    // Jika berbeda, gunakan angka yang lebih besar
    // agar palindrome yang terbentuk tetap sebesar mungkin.
    int kiriValue = int.parse(angka[kiri]);
    int kananValue = int.parse(angka[kanan]);

    if (kiriValue > kananValue) {
      angka[kanan] = angka[kiri];
    } else {
      angka[kiri] = angka[kanan];
    }

    return 1 +
        makePalindrome(
          angka,
          kiri + 1,
          kanan - 1,
        );
  }

  // ============================================================
  // Memaksimalkan palindrome
  // ============================================================
  void maximizePalindrome(
    List<String> angka,
    int kiri,
    int kanan,
    int sisa,
  ) {
    // Base case
    if (kiri > kanan || sisa <= 0) {
      return;
    }

    // Jika posisi sudah melewati tengah
    if (kiri == kanan) {
      // Digit tengah dapat diubah menjadi 9
      // dengan 1 perubahan.
      if (sisa > 0 && angka[kiri] != '9') {
        angka[kiri] = '9';
      }

      return;
    }

    // Jika kedua digit sudah 9,
    // tidak perlu melakukan perubahan.
    if (angka[kiri] == '9' && angka[kanan] == '9') {
      maximizePalindrome(
        angka,
        kiri + 1,
        kanan - 1,
        sisa,
      );
      return;
    }

    // Jika kedua digit belum 9,
    // ubah keduanya menjadi 9.
    if (angka[kiri] != '9' && angka[kanan] != '9') {
      // Karena pada tahap sebelumnya mungkin
      // salah satu digit sudah diubah.
      //
      // Jika kedua digit sama, membutuhkan 2 perubahan.
      // Jika berbeda, berarti salah satunya sudah pernah
      // diubah sehingga cukup 1 perubahan tambahan.
      if (angka[kiri] == angka[kanan]) {
        if (sisa >= 2) {
          angka[kiri] = '9';
          angka[kanan] = '9';

          maximizePalindrome(
            angka,
            kiri + 1,
            kanan - 1,
            sisa - 2,
          );

          return;
        }
      } else {
        if (sisa >= 1) {
          angka[kiri] = '9';
          angka[kanan] = '9';

          maximizePalindrome(
            angka,
            kiri + 1,
            kanan - 1,
            sisa - 1,
          );

          return;
        }
      }
    }

    // Jika hanya salah satu yang bukan 9,
    // dibutuhkan 1 perubahan.
    if (sisa >= 1) {
      angka[kiri] = '9';
      angka[kanan] = '9';

      maximizePalindrome(
        angka,
        kiri + 1,
        kanan - 1,
        sisa - 1,
      );

      return;
    }

    // Lanjut ke pasangan digit berikutnya.
    maximizePalindrome(
      angka,
      kiri + 1,
      kanan - 1,
      sisa,
    );
  }

  // ============================================================
  // Tombol proses
  // ============================================================
  void proses() {
    String s = stringController.text.trim();
    int? k = int.tryParse(kController.text.trim());

    if (s.isEmpty || k == null || k < 0) {
      setState(() {
        hasil = '-1';
      });
      return;
    }

    String result = highestPalindrome(s, k);

    setState(() {
      hasil = result;
    });
  }

  @override
  void dispose() {
    stringController.dispose();
    kController.dispose();
    super.dispose();
  }

  // ============================================================
  // UI
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Highest Palindrome'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            const Text(
              'HIGHEST PALINDROME',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Mencari palindrome terbesar dengan '
              'maksimal k perubahan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: stringController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'String Angka',
                hintText: 'Contoh: 3943',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: kController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah k',
                hintText: 'Contoh: 1',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: proses,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Cari Highest Palindrome',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Output:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hasil.isEmpty ? '-' : hasil,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
