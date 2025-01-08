import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentalin_app/screen/detail_rental.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  List<dynamic> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransaction();
  }

  Future<void> fetchTransaction() async {
    const String apiUrl = 'http://192.168.116.116:8001/api/transactions';
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Connection': 'Keep-Alive',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          transactions = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.primaryColor,
      appBar: AppBar(
        title: Text('Halaman Rental'),
        backgroundColor: Warna.primaryColor,
        foregroundColor: Colors.white,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : transactions.isEmpty
              ? Center(child: Text('Data tidak ditemukan.'))
              : Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaksi = transactions[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DetailRentalScreen(transaksi: transaksi),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 150,
                        child: Card(
                          color: Warna.fifthColor,
                          margin: EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '${transaksi['cars']}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color:
                                              transaksi['status'] ==
                                                      'Sedang Berlangsung'
                                                  ? Colors.blue
                                                  : Colors.green,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          '${transaksi['status']}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
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
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
