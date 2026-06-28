import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/env_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Menampilkan nama Environment untuk memastikan Flavor berjalan
        title: Text('DigiNews [${EnvConfig.environment}]'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            // Tombol ini akan mengarah ke profil untuk tantangan rahasia Lottie
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          // --- BUKTI ANTI-PLAGIASI (NIM DINAMIS) ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              border: const Border(bottom: BorderSide(color: Colors.blueAccent, width: 2)),
            ),
            child: const Column(
              children: [
                Text(
                  'Developer: M Rifky Raihan (20123021)', 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Tema: DigiNews | Dark Mode Aktif (Ganjil)', 
                  style: TextStyle(color: Colors.blueAccent, fontSize: 13),
                ),
              ],
            ),
          ),
          
          // --- KOTAK KOSONG BERITA (PERSIAPAN FAIL-SAFE UI) ---
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.newspaper, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Portal Berita Siap!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    'Menunggu integrasi Dio & Isar...', 
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}