import 'package:flutter/material.dart';
import 'bmi_result.dart';

class UserInput extends StatefulWidget {
  const UserInput({super.key});

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  bool _isMale = true;
  double _height = 170.0;
  double _weight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          // Gradient gelap yang konsisten dengan halaman hasil
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF242435), Color(0xFF1D1E33)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                // Gender Selection
                Row(
                  children: [
                    Expanded(
                      child: _buildGenderCard(
                        Icons.male,
                        "MALE",
                        _isMale,
                        Colors.blueAccent,
                        true,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildGenderCard(
                        Icons.female,
                        "FEMALE",
                        !_isMale,
                        Colors.pinkAccent,
                        false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Height Slider Card
                _buildInputCard(
                  label: "HEIGHT",
                  value: "${_height.toStringAsFixed(0)}",
                  unit: "cm",
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.blueAccent,
                      overlayColor: Colors.blueAccent.withAlpha(32),
                    ),
                    child: Slider(
                      value: _height,
                      min: 100.0,
                      max: 230.0,
                      onChanged: (value) => setState(() => _height = value),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Weight Slider Card
                _buildInputCard(
                  label: "WEIGHT",
                  value: "${_weight.toStringAsFixed(0)}",
                  unit: "kg",
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.pinkAccent,
                      overlayColor: Colors.pinkAccent.withAlpha(32),
                    ),
                    child: Slider(
                      value: _weight,
                      min: 30.0,
                      max: 150.0,
                      onChanged: (value) => setState(() => _weight = value),
                    ),
                  ),
                ),

                const Spacer(),

                // Calculate Button dengan Gradient
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BmiResultScreen(
                        isMale: _isMale,
                        height: _height,
                        weight: _weight,
                      ),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.pinkAccent],
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "CALCULATE",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
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

  // Widget Helper untuk Kartu Gender
  Widget _buildGenderCard(
    IconData icon,
    String label,
    bool isSelected,
    Color activeColor,
    bool setMale,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _isMale = setMale),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? activeColor : Colors.white10,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 50,
              color: isSelected ? activeColor : Colors.white38,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Kartu Input (Height & Weight)
  Widget _buildInputCard({
    required String label,
    required String value,
    required String unit,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                unit,
                style: const TextStyle(color: Colors.white54, fontSize: 16),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
