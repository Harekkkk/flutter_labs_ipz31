import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CornerProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class CornerProvider with ChangeNotifier {
  double _topLeft = 0.0;
  double _topRight = 0.0;
  double _bottomLeft = 0.0;
  double _bottomRight = 0.0;

  double get topLeft => _topLeft;
  double get topRight => _topRight;
  double get bottomLeft => _bottomLeft;
  double get bottomRight => _bottomRight;

  void setTopLeft(double value) {
    _topLeft = value;
    notifyListeners();
  }

  void setTopRight(double value) {
    _topRight = value;
    notifyListeners();
  }

  void setBottomLeft(double value) {
    _bottomLeft = value;
    notifyListeners();
  }

  void setBottomRight(double value) {
    _bottomRight = value;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 11 Provider',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IPZ-31 Artem: Corners Provider"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            PreviewSection(),
            SizedBox(height: 40),
            ConfigurationSection(),
          ],
        ),
      ),
    );
  }
}

class PreviewSection extends StatelessWidget {
  const PreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CornerProvider>();

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(state.topLeft),
          topRight: Radius.circular(state.topRight),
          bottomLeft: Radius.circular(state.bottomLeft),
          bottomRight: Radius.circular(state.bottomRight),
        ),
      ),
      child: const Center(
        child: Text(
          "Target",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ConfigurationSection extends StatelessWidget {
  const ConfigurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CornerProvider>();

    return Column(
      children: [
        _buildSlider("Top Left", state.topLeft, (v) => context.read<CornerProvider>().setTopLeft(v)),
        _buildSlider("Top Right", state.topRight, (v) => context.read<CornerProvider>().setTopRight(v)),
        _buildSlider("Bottom Left", state.bottomLeft, (v) => context.read<CornerProvider>().setBottomLeft(v)),
        _buildSlider("Bottom Right", state.bottomRight, (v) => context.read<CornerProvider>().setBottomRight(v)),
      ],
    );
  }

  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${value.toInt()} px"),
        Slider(
          value: value,
          min: 0,
          max: 75,
          onChanged: onChanged,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}