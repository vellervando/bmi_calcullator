import 'package:flutter/material.dart';
import 'models/bmi_category.dart';
import 'services/bmi_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: const BmiHome());
}

class BmiHome extends StatefulWidget {
  const BmiHome({super.key});
  @override
  State<BmiHome> createState() => _BmiHomeState();
}

class _BmiHomeState extends State<BmiHome> {
  late Future<List<BmiCategory>> _futureCats;
  double _height = 170, _weight = 60;

  @override
  void initState() {
    super.initState();
    _futureCats = BmiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    // Form input tinggi & berat (sama seperti praktikum BMI Anda)
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator (Async)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Height: ${_height.toStringAsFixed(1)} cm'),
            Slider(
              value: _height,
              min: 100,
              max: 250,
              onChanged: (v) => setState(() => _height = v),
            ),
            Text('Weight: ${_weight.toStringAsFixed(1)} kg'),
            Slider(
              value: _weight,
              min: 30,
              max: 150,
              onChanged: (v) => setState(() => _weight = v),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => showResult(context),
              child: const Text('Calculate BMI'),
            ),
          ],
        ),
      ),
    );
  }

  void showResult(BuildContext ctx) {
    final bmi = _weight / ((_height / 100) * (_height / 100));
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => BmiResult(bmi: bmi, futureCats: _futureCats),
      ),
    );
  }
}

class BmiResult extends StatelessWidget {
  final double bmi;
  final Future<List<BmiCategory>> futureCats;
  const BmiResult({required this.bmi, required this.futureCats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Result')),
      body: FutureBuilder<List<BmiCategory>>(
        future: futureCats,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final cats = snap.data!;
          final cat = cats.firstWhere(
            (c) => bmi >= c.min && bmi < c.max,
            orElse: () => BmiCategory(
              min: 0,
              max: double.infinity,
              label: 'Unknown',
              advice: '-',
            ),
          );
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your BMI: ${bmi.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  'Category: ${cat.label}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text('Advice: ${cat.advice}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
