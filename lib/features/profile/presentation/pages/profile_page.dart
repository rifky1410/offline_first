import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/native/method_channel_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Anti-AI: NIM 20123021, digit terakhir = 1 -> Easter Egg muncul setelah 1 klik
  static const int _easterEggTaps = 1;

  int _tapCount = 0;
  bool _showEasterEgg = false;
  Timer? _resetTimer;

  String _reversedNim = '';

  @override
  void initState() {
    super.initState();
    _callNativeReverse();
  }

  Future<void> _callNativeReverse() async {
    final helper = locator<MethodChannelHelper>();
    final result = await helper.reverseNim('20123021');
    if (mounted) setState(() => _reversedNim = result);
  }

  void _onProfileTap() {
    _resetTimer?.cancel();
    _tapCount++;

    if (_tapCount >= _easterEggTaps) {
      _tapCount = 0;
      setState(() => _showEasterEgg = true);
      // Easter Egg tampil 3 detik lalu hilang
      Timer(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showEasterEgg = false);
      });
    } else {
      // Reset hitungan jika tidak klik lagi dalam 1 detik
      _resetTimer = Timer(const Duration(seconds: 1), () {
        _tapCount = 0;
      });
    }
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          _buildContent(),
          if (_showEasterEgg) _buildEasterEgg(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _onProfileTap,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 72,
                backgroundColor: const Color(0xFF1A1A2E),
                child: Icon(
                  Icons.person,
                  size: 72,
                  color: Colors.blueAccent.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ketuk foto $_easterEggTaps kali untuk easter egg!',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          const SizedBox(height: 32),
          _infoCard('Nama', 'M Rifky Raihan'),
          const SizedBox(height: 12),
          _infoCard('NIM', '20123021'),
          const SizedBox(height: 12),
          _infoCard('Mata Kuliah', 'Mobile Programming Lanjut'),
          const SizedBox(height: 12),
          _infoCard('Tema', 'DigiNews Offline-First'),
          const SizedBox(height: 32),
          if (_reversedNim.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Native MethodChannel (Kotlin)',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'NIM: 20123021  →  Reversed: $_reversedNim',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEasterEgg() {
    return Positioned.fill(
      child: Container(
        color: Colors.black87,
        child: Center(
          child: Lottie.asset(
            'assets/animations/easter_egg.json',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.contain,
            repeat: true,
          ),
        ),
      ),
    );
  }
}
