import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class CustomerserviceScreen extends StatelessWidget {
  const CustomerserviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.primaryColor,
      appBar: AppBar(
        title: Text('Layanan Customer'),
        backgroundColor: Warna.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Text('cihuy'),
    );
  }
}
