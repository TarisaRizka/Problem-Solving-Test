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
      title: 'Dense Ranking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DenseRankingPage(),
    );
  }
}

class DenseRankingPage extends StatefulWidget {
  const DenseRankingPage({super.key});

  @override
  State<DenseRankingPage> createState() => _DenseRankingPageState();
}

class _DenseRankingPageState extends State<DenseRankingPage> {
  final TextEditingController jumlahPemainController = TextEditingController();

  final TextEditingController leaderboardController = TextEditingController();

  final TextEditingController jumlahGameController = TextEditingController();

  final TextEditingController skorGitsController = TextEditingController();

  String hasil = '';

  // Fungsi untuk menyelesaikan Dense Ranking
  List<int> denseRanking(
    List<int> leaderboard,
    List<int> skorGits,
  ) {
    // Menghilangkan skor yang sama
    List<int> uniqueScores = leaderboard.toSet().toList();

    List<int> rankings = [];

    for (int skor in skorGits) {
      int rank = 1;

      // Karena leaderboard sudah terurut dari terbesar
      // ke terkecil, cari posisi skor GITS.
      for (int nilai in uniqueScores) {
        if (skor < nilai) {
          rank++;
        } else {
          break;
        }
      }

      rankings.add(rank);
    }

    return rankings;
  }

  void hitungRanking() {
    try {
      // Membaca jumlah pemain
      int jumlahPemain = int.parse(jumlahPemainController.text.trim());

      // Membaca leaderboard
      List<int> leaderboard = leaderboardController.text
          .trim()
          .split(RegExp(r'\s+'))
          .map(int.parse)
          .toList();

      // Membaca jumlah permainan
      int jumlahGame = int.parse(jumlahGameController.text.trim());

      // Membaca skor GITS
      List<int> skorGits = skorGitsController.text
          .trim()
          .split(RegExp(r'\s+'))
          .map(int.parse)
          .toList();

      // Validasi input
      if (leaderboard.length != jumlahPemain) {
        setState(() {
          hasil = 'Jumlah skor leaderboard harus $jumlahPemain.';
        });
        return;
      }

      if (skorGits.length != jumlahGame) {
        setState(() {
          hasil = 'Jumlah skor GITS harus $jumlahGame.';
        });
        return;
      }

      // Memanggil fungsi Dense Ranking
      List<int> rankings = denseRanking(leaderboard, skorGits);

      setState(() {
        hasil = rankings.join(' ');
      });
    } catch (e) {
      setState(() {
        hasil = 'Input tidak valid. Silakan periksa kembali.';
      });
    }
  }

  @override
  void dispose() {
    jumlahPemainController.dispose();
    leaderboardController.dispose();
    jumlahGameController.dispose();
    skorGitsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dense Ranking'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),

            const Text(
              'DENSE RANKING',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Masukkan data permainan GITS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // Jumlah pemain
            TextField(
              controller: jumlahPemainController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Pemain',
                hintText: 'Contoh: 7',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Leaderboard
            TextField(
              controller: leaderboardController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Skor Leaderboard',
                hintText: 'Contoh: 100 100 50 40 40 20 10',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Jumlah game
            TextField(
              controller: jumlahGameController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Permainan GITS',
                hintText: 'Contoh: 4',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // Skor GITS
            TextField(
              controller: skorGitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Skor GITS',
                hintText: 'Contoh: 5 25 50 120',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: hitungRanking,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Hitung Ranking',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Output Ranking:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hasil.isEmpty ? '-' : hasil,
                style: const TextStyle(
                  fontSize: 20,
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
