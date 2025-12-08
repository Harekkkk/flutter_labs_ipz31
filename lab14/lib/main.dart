import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 14 Native',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NativeCameraScreen(),
    );
  }
}

class NativeCameraScreen extends StatefulWidget {
  const NativeCameraScreen({super.key});

  @override
  State<NativeCameraScreen> createState() => _NativeCameraScreenState();
}

class _NativeCameraScreenState extends State<NativeCameraScreen> {
  static const platform = MethodChannel('com.example.lab14/native');
  
  String _nativeTime = 'Unknown time';
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getNativeTime() async {
    String time;
    try {
      final String result = await platform.invokeMethod('getTime');
      time = 'Native Time: $result';
    } on PlatformException catch (e) {
      time = "Failed to get time: '${e.message}'.";
    }

    setState(() {
      _nativeTime = time;
    });
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _image = File(photo.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IPZ-31 Artem: Native Features"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _nativeTime,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _getNativeTime,
              icon: const Icon(Icons.access_time),
              label: const Text("Get Native Time (Kotlin)"),
            ),
            
            const Divider(height: 50, thickness: 2),

            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _image == null
                  ? const Center(child: Text("No image taken"))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _takePhoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Take Photo"),
            ),
          ],
        ),
      ),
    );
  }
}