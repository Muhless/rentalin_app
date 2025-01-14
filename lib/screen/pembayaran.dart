// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PembayaranScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const PembayaranScreen(this.car, {super.key});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  bool isDriverSelected = false;
  int biayaSewa = 0;
  String userId = '';
  String username = '';
  final bool _isLoading = false;

  Future<void> _kirimData(BuildContext context) async {
    if (selectedStartDate == null || selectedEndDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Harap lengkapi semua data sebelum konfirmasi pembayaran.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID tidak ditemukan.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final Map<String, dynamic> requestData = {
      'user_id': userId,
      'car_id': widget.car['id'],
      'rent_date': formatDateWithoutTime(selectedStartDate),
      'return_date': formatDateWithoutTime(selectedEndDate),
      'rent_duration': getDurasiSewa(),
      'driver': isDriverSelected ? 'Ya' : 'Tidak',
      'total': int.tryParse(
        getTotal().replaceAll('Rp.', '').replaceAll(',', ''),
      ),
    };

    try {
      final response = await http.post(
        Uri.parse('http://192.168.28.116:8001/api/rentals'),

        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Data berhasil dikirim: ${response.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Pembayaran Dikonfirmasi'),
              content: Text('Pembayaran telah berhasil dikonfirmasi'),
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
            content: Text(
              'Gagal mengirim data. Pastikan Anda memiliki koneksi internet.',
            ),
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

  Future<void> saveUserData(String username, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('id', userId);
    print('Data disimpan: username = $username, userId = $userId');
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Unknown';
      userId = prefs.getString('id') ?? 'Unknown';
    });
  }

  int durasiRental() {
    if (selectedStartDate == null || selectedEndDate == null) {
      return 0;
    }
    return selectedEndDate!.difference(selectedStartDate!).inDays + 1;
  }

  int getDurasiSewa() {
    if (selectedStartDate != null && selectedEndDate != null) {
      return selectedEndDate!.difference(selectedStartDate!).inDays + 1;
    }
    return 0;
  }

  void getBiayaSewa() {
    widget.car['price'] * getDurasiSewa();
  }

  int getBiayaDriver() {
    return isDriverSelected ? 100000 * getDurasiSewa() : 0;
  }

  String getTotal() {
    int driver = getBiayaDriver();
    int duration = getDurasiSewa();
    int totalCarPrice = widget.car['price'] * duration;
    int total = totalCarPrice + driver;
    return 'Rp. ${NumberFormat('#,###').format(total)}';
  }

  Future<void> _selectDate(
    BuildContext context, {
    bool isStartDate = true,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStartDate
              ? selectedStartDate ?? DateTime.now()
              : selectedEndDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
    }
  }

  String formatDateWithoutTime(DateTime? date) {
    if (date == null) return '';
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String formatTanggal(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  String _formatDateWithoutLocale(DateTime? date) {
    if (date == null) return 'Pilih Tanggal';
    final List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.primaryColor,
      appBar: AppBar(
        backgroundColor: Warna.primaryColor,
        title: Text('Pembayaran', style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text('Konfirmasi Pembatalan'),
                    content: Text(
                      'Apakah Anda yakin ingin membatalkan pembayaran?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Tidak'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Ya'),
                      ),
                    ],
                  ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal Sewa',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap:
                                    () =>
                                        _selectDate(context, isStartDate: true),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal Pengembalian',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap:
                                    () => _selectDate(
                                      context,
                                      isStartDate: false,
                                    ),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Driver',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Rp.100,000/Hari',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Checkbox(
                              value: isDriverSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  isDriverSelected = value ?? false;
                                });
                              },
                              activeColor: Colors.blue,
                              checkColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Warna.thirdColor,
                  border: Border.all(color: Colors.white38),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Perentalan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetailColumn([
                            {'label': 'Customer', 'value': username},
                            {
                              'label': 'Mobil',
                              'value':
                                  '${widget.car['brand']} ${widget.car['model']}',
                            },
                            {
                              'label': 'Harga Sewa',
                              'value':
                                  'Rp ${NumberFormat('#,###').format(widget.car['price'])}/Hari',
                            },
                          ]),
                          _buildDetailColumn([
                            {
                              'label': 'Tanggal Sewa',
                              'value':
                                  selectedStartDate == null
                                      ? 'Belum dipilih'
                                      : _formatDateWithoutLocale(
                                        selectedStartDate,
                                      ),
                            },
                            {
                              'label': 'Tanggal Pengembalian',
                              'value':
                                  selectedEndDate == null
                                      ? 'Belum dipilih'
                                      : _formatDateWithoutLocale(
                                        selectedEndDate,
                                      ),
                            },
                            {
                              'label': 'Durasi Sewa',
                              'value': '${durasiRental()} Hari',
                            },
                          ], alignRight: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Warna.thirdColor,
                  border: Border.all(color: Colors.white38),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Pembayaran',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var detail in [
                                  {
                                    'label': 'Biaya Sewa',
                                    'value':
                                        'Rp. ${NumberFormat('#,###').format(widget.car['price'] * getDurasiSewa())}',
                                  },

                                  {
                                    'label': 'Biaya Driver',
                                    'value':
                                        isDriverSelected
                                            ? 'Rp. ${NumberFormat('#,###').format(100000 * getDurasiSewa())}'
                                            : 'Rp.0',
                                  },
                                  {'label': 'Total', 'value': getTotal()},
                                ])
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          detail['label']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            detail['value']!,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 18,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child:
                    _isLoading
                        ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                          strokeWidth: 4.0,
                        )
                        : ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Konfirmasi'),
                                  content: Text(
                                    'Apakah Anda yakin ingin mengonfirmasi pembayaran ini?',
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
                                        _kirimData(context);
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/rental',
                                        );
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
                              horizontal: 30,
                              vertical: 15,
                            ),
                            textStyle: TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Konfirmasi Pembayaran'),
                        ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailColumn(
  List<Map<String, String>> details, {
  bool alignRight = false,
}) {
  return Column(
    crossAxisAlignment:
        alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children:
        details.map((detail) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment:
                  alignRight
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  detail['label']!,
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
                Text(
                  detail['value']!,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          );
        }).toList(),
  );
}
