// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/home.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class PembayaranScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const PembayaranScreen(this.car, {super.key});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: GestureDetector(
          onTap: () {
            _showExitConfirmationDialog(context);
          },
          child: AppBar(
            backgroundColor: Warna.primaryColor,
            title: Text('Pembayaran', style: TextStyle(color: Colors.white)),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Warna.primaryColor,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Warna.fifthColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Image.network(
                        '${widget.car['image_url']}',
                        height: 150,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      _buildPaymentMethodOption(
                        context,
                        'Transfer Bank',
                        Icons.account_balance,
                      ),
                      _buildPaymentMethodOption(
                        context,
                        'Kartu Kredit/Debit',
                        Icons.credit_card,
                      ),
                      _buildPaymentMethodOption(
                        context,
                        'E-wallet (OVO, DANA, etc.)',
                        Icons.wallet_travel,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Konfirmasi Pembayaran',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOption(
    BuildContext context,
    String method,
    IconData icon,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      leading: Icon(icon, size: 40, color: Colors.white),
      title: Text(method, style: TextStyle(fontSize: 18, color: Colors.white)),
      onTap: () {
        _showPaymentMethodDialog(context, method);
      },
    );
  }

  void _showPaymentMethodDialog(BuildContext context, String method) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Metode Pembayaran Dipilih'),
          content: Text('Anda memilih metode pembayaran: $method'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content: Text('Apakah Anda yakin ingin melanjutkan pembayaran?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                _showSuccessDialog(context);
              },
              child: Text('Ya, Bayar'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pembayaran Berhasil'),
          content: Text('Pembayaran Anda telah berhasil diproses.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

void _showExitConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Konfirmasi"),
        content: Text("Yakin ingin membatalkan perentalan?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Tidak"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: Text("Ya"),
          ),
        ],
      );
    },
  );
}
