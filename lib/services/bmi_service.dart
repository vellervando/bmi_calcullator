import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bmi_category.dart';

class BmiService {
  static const _endpoint =
      'https://gist.githubusercontent.com/vellervando/7a6c66b9108bfd510263a6f183d166de/raw/e2ef874c802e9aba2099b45c753ecdcb6b65ac5d/bmi_categories.json';

  /// Mengambil daftar kategori BMI dari server
  static Future<List<BmiCategory>> fetchCategories() async {
    final response = await http
        .get(Uri.parse(_endpoint))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data
          .map((item) => BmiCategory.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal memuat data (HTTP ${response.statusCode})');
    }
  }
}
