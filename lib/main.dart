import 'package:flutter/material.dart';
import 'core/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Menjalankan Dependency Injection (Nanti kita isi kodenya)
  setupLocator();
  
  runApp(const DigiNewsApp());
}

class DigiNewsApp extends StatelessWidget {
  const DigiNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DigiNews',
      theme: ThemeData(
        brightness: Brightness.dark, // Wajib Dark Mode (NIM Ganjil)
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('DigiNews: Proyek Dimulai')),
      ),
    );
  }
}