package com.example.oflline_first

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.oflline_first/nim"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "reverseNim") {
                    val nim = call.argument<String>("nim") ?: ""

                    // Anti-AI: Balik urutan String NIM di Kotlin
                    // Contoh: "20123021" -> "12032102"
                    val reversed = nim.reversed()

                    // Tampilkan hasil sebagai Native Toast Android
                    Toast.makeText(
                        applicationContext,
                        "NIM: $nim -> Reversed: $reversed",
                        Toast.LENGTH_LONG
                    ).show()

                    result.success(reversed)
                } else {
                    result.notImplemented()
                }
            }
    }
}
