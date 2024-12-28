import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rentalin_app/screen/mobil/family/detail.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class ListFamilyCars extends StatefulWidget {
  @override
  _ListFamilyCarsState createState() => _ListFamilyCarsState();
}

class _ListFamilyCarsState extends State<ListFamilyCars> {
  List<dynamic> cars = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/cars');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        setState(() {
          cars = json.decode(response.body);
          isLoading = false;
        });
        print("Cars fetched: ${cars}");
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobil Keluarga', style: TextStyle(color: Colors.white)),
        backgroundColor: Warna.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Warna.primaryColor,
        child:
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
                                    (context) => DetailFamilyCars(selectedCar),
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
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: Warna.secondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                'Rp${car['price']}/Hari',
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
      ),
    );
  }
}
