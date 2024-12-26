import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    final url = Uri.parse('http://10.0.2.2:8000/api/cars/family');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          cars = data;
          isLoading = false;
        });
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
      appBar: AppBar(title: Text('Family Cars')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : cars.isEmpty
              ? Center(child: Text('No cars found.'))
              : Container(
                margin: EdgeInsets.all(30),
                child: ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          car['icon_path'] ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.directions_car);
                          },
                        ),
                        title: Text('${car['brand']} ${car['model']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Seat: ${car['kapasitas']}'),
                            Text('Transmisi: ${car['transmisi']}'),
                            Text('Harga: Rp ${car['harga']} / hari'),
                          ],
                        ),
                        trailing: Image.asset(
                          car['image_path'] ?? '',
                          width: 100,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
