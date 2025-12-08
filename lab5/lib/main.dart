import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Константи згідно варіанту 27
const double _size = 75.0;
const Color _bgColor = Colors.blue;
const Color _borderColor = Colors.black;
const double _borderWidth = 2.0;
const double _borderRadius = 10.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 Variant 27',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'IPZ-31: Artem\'s Pixel 6'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // ScrollView потрібен, бо цифра велика (75 * 5 = 375 пікселів висоти + відступи)
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _buildSix(),
            ),
          ),
        ),
      ),
    );
  }

  // Логіка побудови цифри 6
  List<Widget> _buildSix() {
    return [
      _buildRowFull(),    // Верхня лінія (XXX)
      _buildRowLeft(),    // Ліва сторона (X..)
      _buildRowFull(),    // Середня лінія (XXX)
      _buildRowSides(),   // Боки знизу (X.X)
      _buildRowFull(),    // Нижня лінія (XXX)
    ];
  }

  // Рядок з 3 заповнених пікселів
  Widget _buildRowFull() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(),
        _buildDot(),
        _buildDot(),
      ],
    );
  }

  // Рядок: піксель зліва, далі пусто
  Widget _buildRowLeft() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(),
        _buildEmpty(),
        _buildEmpty(),
      ],
    );
  }

  // Рядок: пікселі по боках, посередині пусто
  Widget _buildRowSides() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(),
        _buildEmpty(),
        _buildDot(),
      ],
    );
  }

  // Побудова самого пікселя (Container)
  Widget _buildDot() {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
        border: Border.all(
          color: _borderColor,
          width: _borderWidth,
        ),
      ),
    );
  }

  // Побудова порожнього місця (SizedBox)
  Widget _buildEmpty() {
    return const SizedBox(
      width: _size,
      height: _size,
    );
  }
}
