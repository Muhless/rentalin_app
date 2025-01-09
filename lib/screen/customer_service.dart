import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rentalin Customer Service',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Warna.primaryColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Warna.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nomor yang dapat dihubungi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Cabang Kelompok 1',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Text(
              'Admin Tyo',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              '2155201073',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Admin Farizky',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              '2155201068',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Admin Febriyansyah',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              '2155201087',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Admin Andre',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              '2155201059',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Admin Nuhta',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              '2155201051',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
