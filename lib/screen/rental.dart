import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentalin_app/screen/detail_rental.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';
import 'package:intl/intl.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  List<dynamic> rentals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransaction();
  }

  Future<void> fetchTransaction() async {
    const String apiUrl = 'http://192.168.28.116:8001/api/rentals';
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
          rentals = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load rentals');
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : rentals.isEmpty
              ? Center(
                child: Text(
                  'Belum ada data rental',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
              : Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: ListView.builder(
                  itemCount: rentals.length,
                  itemBuilder: (context, index) {
                    final rental = rentals[index];
                    return GestureDetector(
                      onTap:
                          rental['status'] == 'Disetujui' ||
                                  rental['status'] == 'Selesai'
                              ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            DetailRentalScreen(rental: rental),
                                  ),
                                );
                              }
                              : null,
                      child: SizedBox(
                        height: 150,
                        child: Card(
                          color:
                              rental['status'] == 'Menunggu persetujuan'
                                  ? Colors.grey[600]
                                  : rental['status'] == 'Ditolak'
                                  ? Colors.grey[600]
                                  : Warna.fifthColor,
                          margin: EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(
                                      rental['car']['image_url'],
                                      width: 120,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${rental['car']['brand']} ${rental['car']['model']}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(
                                                  rental['rent_date'],
                                                ),
                                              ),
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(width: 5),
                                            Text('-'),
                                            SizedBox(width: 5),
                                            Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(
                                                  rental['return_date'],
                                                ),
                                              ),
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color:
                                                rental['status'] ==
                                                        'Menunggu persetujuan'
                                                    ? Colors.blue
                                                    : rental['status'] ==
                                                        'Disetujui'
                                                    ? Colors.green
                                                    : rental['status'] ==
                                                        'Selesai'
                                                    ? Colors.teal
                                                    : Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            '${rental['status']}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
