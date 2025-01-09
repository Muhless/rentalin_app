// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class DetailRentalScreen extends StatefulWidget {
  final dynamic rental;

  const DetailRentalScreen({super.key, required this.rental});

  @override
  _DetailRentalScreenState createState() => _DetailRentalScreenState();
}

Future<void> _updateDataTransaksi(
  BuildContext context,
  Map<String, dynamic> rental,
) async {
  DateTime returnDate = DateTime.parse(rental['return_date']);
  DateTime actualReturnDate = DateTime.now().add(Duration(days: 5));
  int lateDays = calculateLateDays(returnDate, actualReturnDate);

  final Map<String, dynamic> requestData = {
    'actual_return_date': actualReturnDate.toIso8601String(),
    'late_days': lateDays,
    'penalty_fee': lateDays * 100000,
    'status': 'Selesai',
  };

  final Map<String, dynamic> carUpdateData = {'status': 'Tersedia'};

  try {
    final response = await http.put(
      Uri.parse('http://192.168.116.116:8001/api/rentals/${rental['id']}'),

      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Data rental berhasil diperbarui : ${response.body}');

      final carResponse = await http.put(
        Uri.parse(
          'http://192.168.116.116:8001/api/cars/${rental['car']['id']}',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(carUpdateData),
      );
      if (carResponse.statusCode == 200 || carResponse.statusCode == 201) {
        print('Mobil berhasil diperbarui menjadi Tersedia');
      } else {
        print(
          'Gagal memperbarui mobil: ${carResponse.statusCode} - ${carResponse.body}',
        );
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selesai'),
            content: Text(
              'Rental telah berhasil diselesaikan dan mobil kini tersedia',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/rental');
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print('Gagal mengirim data: ${response.statusCode} - ${response.body}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Gagal mengirim data.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Gagal mengirim data'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

int calculateLateDays(DateTime returnDate, DateTime actualReturnDate) {
  final difference = actualReturnDate.difference(returnDate).inDays;
  return difference < 0 ? 0 : difference;
}

class _DetailRentalScreenState extends State<DetailRentalScreen> {
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rental = widget.rental;
    return Scaffold(
      backgroundColor: Warna.thirdColor,
      appBar: AppBar(
        title: Text('Detail Rental'),
        backgroundColor: Warna.thirdColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child:
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildDetailRow(
                      'Customer',
                      '${rental['user']['username']}',
                    ),
                    _buildDetailRow(
                      'Mobil',
                      '${rental['car']['brand']} ${rental['car']['model']}',
                    ),
                    _buildDetailRow(
                      'Tanggal Perentalan',
                      DateFormat(
                        'dd MMMM yyyy',
                      ).format(DateTime.parse(rental['rent_date'])),
                    ),
                    _buildDetailRow(
                      'Tanggal Selesai Perentalan',
                      DateFormat(
                        'dd MMMM yyyy',
                      ).format(DateTime.parse(rental['return_date'])),
                    ),
                    _buildDetailRow(
                      'Durasi Rental',
                      '${rental['rent_duration']} hari',
                    ),
                    _buildDetailRow('Driver', '${rental['driver']}'),
                    _buildDetailRow(
                      'Total',
                      'Rp ${NumberFormat('#,###').format(rental['total'])}',
                    ),
                    if (rental['status'] == 'Selesai') ...[
                      _buildDetailRow(
                        'Tanggal Pengembalian Mobil',
                        DateFormat(
                          'dd MMMM yyyy',
                        ).format(DateTime.parse(rental['actual_return_date'])),
                      ),
                      _buildDetailRow(
                        'Keterlambatan',
                        '${rental['late_days']} Hari',
                      ),
                      _buildDetailRow(
                        'Denda',
                        'Rp ${NumberFormat('#,###').format(rental['penalty_fee'])}',
                      ),
                      _buildDetailRow('Status', '${rental['status']}'),
                    ],
                    SizedBox(height: 40),
                    if (rental['status'] != 'Selesai')
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Konfirmasi'),
                                content: Text(
                                  'Apakah Anda yakin ingin menyelesaikan rental ini?',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _updateDataTransaksi(context, rental);
                                       Navigator.pushReplacementNamed(context, '/rental');
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 15,
                          ),
                          textStyle: TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Selesaikan Rental'),
                      ),
                  ],
                ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      decoration: BoxDecoration(color: Warna.thirdColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 15, color: Colors.white70)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
