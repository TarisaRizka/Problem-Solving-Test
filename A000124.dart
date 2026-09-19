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
      title: 'A000124 Sloane',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const A000124Page(),
    );
  }
}

class A000124Page extends StatefulWidget {
  const A000124Page({super.key});

  @override
  State<A000124Page> createState() => _A000124PageState();
}

class _A000124PageState extends State<A000124Page> {
  final TextEditingController inputController = TextEditingController();

  String hasil = '';

  // Fungsi A000124 of Sloane's OEIS
  int a000124(int n) {
    return 1 + (n * (n + 1)) ~/ 2;
  }

  void generateSequence() {
    int? n = int.tryParse(inputController.text);

    if (n == null || n <= 0) {
      setState(() {
        hasil = 'Masukkan angka lebih dari 0';
      });
      return;
    }

    List<int> sequence = [];

    for (int i = 0; i < n; i++) {
      sequence.add(a000124(i));
    }

    setState(() {
      hasil = sequence.join('-');
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A000124 Sloane\'s OEIS'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            const Text(
              'A000124 of Sloane\'s OEIS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Masukkan jumlah bilangan yang ingin ditampilkan:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Input',
                hintText: 'Contoh: 7',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateSequence,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Generate',
                  style: TextStyle(fontSize: 18),
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
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hasil.isEmpty ? '-' : hasil,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
