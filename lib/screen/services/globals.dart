import 'package:flutter/material.dart';

const String baseURL = 'http://10.0.2.2:8000/api/';
const Map<String, String> headers = {'Content-Type': 'application/json'};

void errorSnackBar(BuildContext context, String text) {
  // Memastikan ada Scaffold yang sedang aktif di context
  if (ScaffoldMessenger.of(context) != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
        duration: const Duration(
            seconds: 5), // Menambah durasi untuk memperjelas error
      ),
    );
  }
}
