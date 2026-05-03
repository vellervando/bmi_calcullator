import 'package:flutter/material.dart';
import 'models/bmi_category.dart';
import 'services/bmi_service.dart';
import 'screens/user_input.dart'; // Pastikan path ini sesuai dengan letak file UserInput kamu

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Menghilangkan banner debug agar lebih bersih
      title: 'BMI Calculator',
      theme: ThemeData(
        // Mengatur tema dasar menjadi gelap agar tidak 'flash' putih saat loading
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF242435),
        scaffoldBackgroundColor: const Color(0xFF242435),
        useMaterial3: true,
      ),
      // Kita langsung arahkan home ke UserInput yang baru agar UI barunya terlihat
      home: const UserInput(),
    );
  }
}
