import 'package:flutter/material.dart';
import '../models/bmi_category.dart';
import '../services/storage_service.dart';

class BmiResultScreen extends StatelessWidget {
  final bool isMale;
  final double height;
  final double weight;

  const BmiResultScreen({
    super.key,
    required this.isMale,
    required this.height,
    required this.weight,
  });

  // Logika sistem tetap sama
  double calculateBmi() => weight / ((height / 100) * (height / 100));

  BmiCategory getCategory(double bmi) {
    if (bmi < 18.5) {
      return BmiCategory(
        min: 0,
        max: 18.5,
        label: 'Underweight',
        advice: 'Perbanyak makanan bergizi',
      );
    } else if (bmi < 25.0) {
      return BmiCategory(
        min: 18.5,
        max: 25.0,
        label: 'Normal',
        advice: 'Pertahankan pola hidup sehat',
      );
    } else if (bmi < 30.0) {
      return BmiCategory(
        min: 25.0,
        max: 30.0,
        label: 'Overweight',
        advice: 'Kurangi makanan berlemak & olahraga rutin',
      );
    } else {
      return BmiCategory(
        min: 30.0,
        max: double.infinity,
        label: 'Obese',
        advice: 'Segera konsultasi dokter & atur pola makan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bmi = calculateBmi();
    final cat = getCategory(bmi);

    return Scaffold(
      // Menggunakan extend agar background gradient sampai ke atas
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // Gradient modern sesuai warna kategori
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cat.color.withOpacity(0.8),
              const Color(0xFF242435), // Warna gelap elegan
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "HASIL ANALISIS",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 30),

                // Card Utama dengan gaya modern
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat.icon, size: 100, color: cat.color),
                          const SizedBox(height: 20),
                          Text(
                            cat.label.toUpperCase(),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: cat.color,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            bmi.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "kg/m²",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 18,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                            child: Divider(color: Colors.white24, thickness: 1),
                          ),
                          Text(
                            cat.advice,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Tombol Clear Cache yang lebih minimalis
                TextButton.icon(
                  onPressed: () async {
                    await StorageService.clearCache();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.white,
                          content: Text(
                            "Cache dibersihkan",
                            style: TextStyle(color: cat.color),
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.white60),
                  label: const Text(
                    "CLEAR HISTORY",
                    style: TextStyle(color: Colors.white60),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
