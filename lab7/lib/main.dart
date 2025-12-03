import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7 Variant 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RGBPickerScreen(),
    );
  }
}

class RGBPickerScreen extends StatefulWidget {
  const RGBPickerScreen({super.key});

  @override
  State<RGBPickerScreen> createState() => _RGBPickerScreenState();
}

class _RGBPickerScreenState extends State<RGBPickerScreen> {
  // Змінні стану для зберігання значень кольорів (0-255)
  double _red = 0.0;
  double _green = 0.0;
  double _blue = 0.0;

  @override
  Widget build(BuildContext context) {
    // Формуємо колір на основі поточного стану
    final Color currentColor = Color.fromRGBO(
      _red.toInt(),
      _green.toInt(),
      _blue.toInt(),
      1.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("IPZ-31: Artem's RGB Picker"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Відображення кольору
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Center(
                child: Text(
                  "R: ${_red.toInt()}  G: ${_green.toInt()}  B: ${_blue.toInt()}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // Контрастний колір тексту (білий або чорний залежно від яскравості фону)
                    color: currentColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Слайдери
            _buildColorSlider("Red", Colors.red, _red, (value) {
              setState(() => _red = value);
            }),
            _buildColorSlider("Green", Colors.green, _green, (value) {
              setState(() => _green = value);
            }),
            _buildColorSlider("Blue", Colors.blue, _blue, (value) {
              setState(() => _blue = value);
            }),
          ],
        ),
      ),
    );
  }

  // Допоміжний віджет для слайдера
  Widget _buildColorSlider(String label, Color color, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ${value.toInt()}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Slider(
          value: value,
          min: 0,
          max: 255,
          activeColor: color,
          onChanged: onChanged,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}