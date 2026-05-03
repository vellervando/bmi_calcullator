#ETS Praktikum Pemrograman Mobile
##Panduan Pengembangan Aplikasi: BMI Calculator
###Dokumentasi Prosedur Praktikum (Pertemuan 3 - 5)

####1. Inisialisasi Proyek
Konfigurasi Lingkungan: Pastikan Flutter SDK dan Dart telah terinstalasi serta terkonfigurasi pada sistem.

Generasi Proyek: Jalankan perintah flutter create bmi_calculator melalui terminal.

Arsitektur Folder: Terapkan pola struktur direktori yang rapi untuk pemisahan kepentingan (separation of concerns):

models/: Untuk definisi struktur data.

services/: Untuk logika bisnis dan pengolahan data.

screens/: Untuk tata letak antarmuka utama.

widgets/: Untuk komponen UI yang dapat digunakan kembali (reusable).

####2. Konfigurasi Entry Point
Modifikasi file main.dart untuk mendefinisikan tema global aplikasi (Theming) dan menetapkan UserInputScreen sebagai gerbang utama (Initial Route).

####3. Pemodelan Data (Model)
Implementasi bmi_category.dart: Membangun class BmiCategory yang mencakup atribut rentang nilai (min, max), label kategori, serta saran kesehatan (advice). Tambahkan getter untuk menentukan warna dan ikon secara dinamis berdasarkan kategori.

####4. Layer Layanan (Service)
BmiService: Logika untuk memetakan hasil perhitungan ke kategori yang sesuai, baik melalui data lokal maupun integrasi JSON.

StorageService: Implementasi persistence data menggunakan package shared_preferences untuk menyimpan histori tinggi dan berat badan pengguna secara lokal.

####5. Pengembangan Antarmuka Input (Input Screen)
Menyusun user_input.dart yang terdiri dari:

Komponen interaktif GenderToggle.

Input numerik melalui TextField dan kontrol presisi menggunakan Slider.

Tombol kalkulasi yang memicu fungsi navigasi menuju BmiResultScreen.

####6. Visualisasi Hasil (Result Screen)
Implementasi bmi_result.dart:

Melakukan kalkulasi BMI berdasarkan formula standar.

Menampilkan skor numerik, label kategori, saran medis, serta representasi visual (warna dan ikon) yang relevan.

####7. Komponen Reusable (Widget)
Pengembangan gender_toggle.dart: Membuat widget khusus yang menangani logika pemilihan gender dengan umpan balik visual yang interaktif.

####8. Evaluasi dan Pengujian (Testing)
Eksekusi Program: Menjalankan aplikasi menggunakan perintah flutter run.

Uji Fungsionalitas: Memvalidasi akurasi input data (manual vs slider) dan memastikan algoritma perhitungan menghasilkan kategori yang valid sesuai standar kesehatan.


##Halaman Utama
<img width="1909" height="983" alt="Screenshot 2026-05-03 172153" src="https://github.com/user-attachments/assets/d81892a5-8779-43a2-85a1-856379712a28" />


##Halaman Result
<img width="1917" height="973" alt="Screenshot 2026-05-03 172211" src="https://github.com/user-attachments/assets/583c1c33-81de-4fa9-be33-800eec34ac32" />
