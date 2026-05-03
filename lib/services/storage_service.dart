import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bmi_category.dart';

class StorageService {
  static const _keyHeight = 'height_cm';
  static const _keyWeight = 'weight_kg';
  static const _keyCategories = 'bmi_categories_json';

  /// Simpan tinggi & berat
  static Future<void> saveInputs(double height, double weight) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyHeight, height);
    await prefs.setDouble(_keyWeight, weight);
  }

  /// Load tinggi & berat (default 170 & 60)
  static Future<Map<String, double>> loadInputs() async {
    final prefs = await SharedPreferences.getInstance();
    final h = prefs.getDouble(_keyHeight) ?? 170.0;
    final w = prefs.getDouble(_keyWeight) ?? 60.0;
    return {'height': h, 'weight': w};
  }

  /// Cache kategori BMI sebagai JSON string
  static Future<void> cacheCategories(List<BmiCategory> cats) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = json.encode(
      cats
          .map(
            (c) => {
              'min': c.min,
              'max': c.max,
              'label': c.label,
              'advice': c.advice,
            },
          )
          .toList(),
    );
    await prefs.setString(_keyCategories, jsonStr);
  }

  /// Load kategori dari cache (atau null jika belum ada)
  static Future<List<BmiCategory>?> loadCachedCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_keyCategories);
    if (str == null) return null;
    final List data = json.decode(str);
    return data
        .map((item) => BmiCategory.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Hapus semua cache
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyCategories);
  }
}
