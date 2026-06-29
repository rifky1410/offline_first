import 'package:flutter/services.dart';

class MethodChannelHelper {
  static const _channel = MethodChannel('com.example.oflline_first/nim');

  // Kirim NIM ke Kotlin, terima hasil reversed + ditampilkan sebagai Toast Android
  Future<String> reverseNim(String nim) async {
    try {
      final result = await _channel.invokeMethod<String>('reverseNim', {'nim': nim});
      return result ?? nim.split('').reversed.join();
    } on PlatformException catch (e) {
      return 'Error: ${e.message}';
    }
  }
}
