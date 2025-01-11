// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rentalin_app/screen/detail.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class ListCarScreen extends StatefulWidget {
  const ListCarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListFamilyCarsState createState() => _ListFamilyCarsState();
}

class _ListFamilyCarsState extends State<ListCarScreen> {
  List<dynamic> cars = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    const String apiUrl = 'http://192.168.28.116:8001/api/cars';
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
          cars = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load cars');
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
        title: Text('List Mobil', style: TextStyle(color: Colors.white)),
        backgroundColor: Warna.primaryColor,
        foregroundColor: Colors.white,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : cars.isEmpty
              ? Center(child: Text('Mobil tidak ditemukan.'))
              : Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return SizedBox(
                      height: 200,
                      child: GestureDetector(
                        onTap: () {
                          final selectedCar = cars[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => DetailCarScreen(selectedCar),
                            ),
                          );
                        },
                        child: Card(
                          color: Warna.fifthColor,
                          margin: EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${car['brand']}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '${car['model']}',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 28,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              color: Warna.secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              'Rp ${NumberFormat('#,###').format(car['price'])} / Hari',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.network(
                                      car['image_url'] ??
                                          'https://via.placeholder.com/150',
                                      height: 130,
                                      width: 170,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        print("Error loading image: $error");
                                        return Icon(Icons.error);
                                      },
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
