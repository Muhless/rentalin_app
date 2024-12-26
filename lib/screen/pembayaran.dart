// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/home.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';


class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({super.key});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Warna.sixthColor,
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(top: 38, left: 20),
                child: GestureDetector(
                  onTap: () {
                    _showExitConfirmationDialog(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Pemesanan',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text('Mobil yang disewa'),
                        subtitle: Text('Toyota Avanza - 3 Hari'),
                        trailing: Text('Rp 750,000'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Metode Pembayaran',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                          // Logika konfirmasi pembayaran
                          _showConfirmationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOption(
      BuildContext context, String method, IconData icon) {
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
              onPressed: () => Navigator.push,
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                _showSuccessDialog;
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
                // Navigasi ke halaman lain setelah pembayaran berhasil
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
        content: Text(
          "Yakin ingin membatalkan perentalan?",
        ),
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
