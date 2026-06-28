import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/config/env_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Menjalankan Dependency Injection
  setupLocator();
  
  runApp(const DigiNewsApp());
}

class DigiNewsApp extends StatelessWidget {
  const DigiNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: !EnvConfig.isProduction,
      title: 'DigiNews',
      theme: ThemeData(
        brightness: Brightness.dark, // Wajib Dark Mode sesuai NIM Ganjil
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("DigiNews Home")),
        body: const Center(
          child: Text("Portal Berita Siap!"),
        ),
      ),
    );
  }
}