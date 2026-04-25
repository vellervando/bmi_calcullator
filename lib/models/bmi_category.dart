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
}
