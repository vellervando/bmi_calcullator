import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E21),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
      ),
      home: UserInput(),
    ),
  );
}

class UserInput extends StatefulWidget {
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
      appBar: AppBar(
        title: const Text('BMI CALCULATOR', style: TextStyle(letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row Pilihan Gender
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GenderCard(
                    onPress: () => setState(() => _isMale = true),
                    color: _isMale
                        ? const Color(0xFF1D1E33)
                        : const Color(0xFF111328),
                    cardChild: GenderIcon(
                      icon: Icons.male,
                      label: 'MALE',
                      isActive: _isMale,
                    ),
                    border: _isMale
                        ? Border.all(color: const Color(0xFFEB1555), width: 2)
                        : null,
                  ),
                ),
                Expanded(
                  child: GenderCard(
                    onPress: () => setState(() => _isMale = false),
                    color: !_isMale
                        ? const Color(0xFF1D1E33)
                        : const Color(0xFF111328),
                    cardChild: GenderIcon(
                      icon: Icons.female,
                      label: 'FEMALE',
                      isActive: !_isMale,
                    ),
                    border: !_isMale
                        ? Border.all(color: const Color(0xFFEB1555), width: 2)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          // Bagian Slider Tinggi
          Expanded(
            child: GenderCard(
              color: const Color(0xFF1D1E33),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'HEIGHT',
                    style: TextStyle(fontSize: 18, color: Color(0xFF8D8E98)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${_height.round()}',
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                        'cm',
                        style: TextStyle(color: Color(0xFF8D8E98)),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: const Color(0xFF8D8E98),
                      thumbColor: const Color(0xFFEB1555),
                      overlayColor: const Color(0x29EB1555),
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 15.0,
                      ),
                    ),
                    child: Slider(
                      value: _height,
                      min: 100,
                      max: 230,
                      onChanged: (val) => setState(() => _height = val),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bagian Input Berat
          Expanded(
            child: GenderCard(
              color: const Color(0xFF1D1E33),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'WEIGHT',
                    style: TextStyle(fontSize: 18, color: Color(0xFF8D8E98)),
                  ),
                  Text(
                    '${_weight.round()}',
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Slider(
                    value: _weight,
                    min: 20,
                    max: 180,
                    activeColor: const Color(0xFFEB1555),
                    onChanged: (val) => setState(() => _weight = val),
                  ),
                ],
              ),
            ),
          ),
          // Tombol Hitung
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BmiResult(height: _height, weight: _weight),
              ),
            ),
            child: Container(
              color: const Color(0xFFEB1555),
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 80,
              child: const Center(
                child: Text(
                  'CALCULATE',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Komponen Card Kostum
class GenderCard extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final VoidCallback? onPress;
  final BoxBorder? border;

  GenderCard({
    required this.color,
    required this.cardChild,
    this.onPress,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: border,
        ),
        child: cardChild,
      ),
    );
  }
}

class GenderIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  GenderIcon({required this.icon, required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80,
          color: isActive ? Colors.white : const Color(0xFF8D8E98),
        ),
        const SizedBox(height: 15),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: isActive ? Colors.white : const Color(0xFF8D8E98),
          ),
        ),
      ],
    );
  }
}

class BmiResult extends StatelessWidget {
  final double height;
  final double weight;

  const BmiResult({required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    double bmi = weight / ((height / 100) * (height / 100));

    String resultText;
    String interpretation;
    Color color;

    if (bmi >= 25) {
      resultText = 'OVERWEIGHT';
      interpretation =
          'You have a higher than normal body weight. Try to exercise more!';
      color = Colors.redAccent;
    } else if (bmi > 18.5) {
      resultText = 'NORMAL';
      interpretation = 'You have a normal body weight. Good job!';
      color = const Color(0xFF24D876);
    } else {
      resultText = 'UNDERWEIGHT';
      interpretation =
          'You have a lower than normal body weight. You can eat a bit more.';
      color = Colors.blueAccent;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI RESULT'),
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Your Result',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GenderCard(
              color: const Color(0xFF1D1E33),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    resultText,
                    style: TextStyle(
                      color: color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      interpretation,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: const Color(0xFFEB1555),
              height: 80,
              child: const Center(
                child: Text(
                  'RE-CALCULATE',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
