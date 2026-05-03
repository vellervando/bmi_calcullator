import 'package:flutter/material.dart';

class BmiCategory {
  final double min, max;
  final String label, advice;

  BmiCategory({
    required this.min,
    required this.max,
    required this.label,
    required this.advice,
  });

  factory BmiCategory.fromJson(Map<String, dynamic> json) {
    return BmiCategory(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
      label: json['label'] as String,
      advice: json['advice'] as String,
    );
  }

  // Tambahkan Getter Color untuk mengatasi error
  Color get color {
    switch (label.toLowerCase()) {
      case 'underweight':
        return Colors.blueAccent;
      case 'normal':
        return Colors.greenAccent;
      case 'overweight':
        return Colors.orangeAccent;
      case 'obese':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  // Tambahkan Getter Icon untuk mendukung UI baru
  IconData get icon {
    switch (label.toLowerCase()) {
      case 'underweight':
        return Icons.monitor_weight_outlined;
      case 'normal':
        return Icons.check_circle_outline;
      case 'overweight':
        return Icons.warning_amber_rounded;
      case 'obese':
        return Icons.dangerous_outlined;
      default:
        return Icons.help_outline;
    }
  }
}
