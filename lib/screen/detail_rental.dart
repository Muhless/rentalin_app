// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class DetailRentalScreen extends StatefulWidget {
  final dynamic rental;

  const DetailRentalScreen({super.key, required this.rental});

  @override
  _DetailRentalScreenState createState() => _DetailRentalScreenState();
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
      backgroundColor: Warna.primaryColor,
      appBar: AppBar(
        title: Text('Detail rental'),
        backgroundColor: Warna.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildDetailRow(
                        'Customer',
                        '${rental['user']['username']}',
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow(
                        'Mobil',
                        '${rental['car']['brand']} ${rental['car']['model']}',
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow(
                        'Tanggal Perentalan',
                        DateFormat(
                          'dd MMMM yyyy',
                        ).format(DateTime.parse(rental['rent_date'])),
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow(
                        'Tanggal Pengembalian',
                        DateFormat(
                          'dd MMMM yyyy',
                        ).format(DateTime.parse(rental['return_date'])),
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow(
                        'Durasi Rental',
                        '${rental['rent_duration']} hari',
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow('Driver', '${rental['driver']}'),
                      SizedBox(height: 10),
                      _buildDetailRow('Total', 'Rp ${rental['total']}'),
                      SizedBox(height: 10),
                      _buildDetailRow('Status', '${rental['status']}'),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Warna.fifthColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
