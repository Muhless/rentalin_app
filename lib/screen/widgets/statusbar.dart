import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class SystemUIHelper {
  // Fungsi untuk membuat status bar transparan
  static void setTransparentStatusBar(
      {Brightness iconBrightness = Brightness.dark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Membuat status bar transparan
        statusBarIconBrightness: iconBrightness, // Warna ikon (dark/light)
      ),
    );
  }

  // Fungsi tambahan (jika diperlukan) untuk set status bar dengan warna tertentu
  static void setCustomStatusBar({
    required Color color,
    Brightness iconBrightness = Brightness.dark,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color, // Warna custom untuk status bar
        statusBarIconBrightness: iconBrightness, // Warna ikon
      ),
    );
  }
}
