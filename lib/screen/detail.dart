// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/pembayaran.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailCarScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const DetailCarScreen(this.car, {super.key});

  @override
  State<DetailCarScreen> createState() => _DetailFamilyCars();
}

class _DetailFamilyCars extends State<DetailCarScreen> {
  late String _username;

  // Controllers for the Edit Dialog
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _capacityController;
  late TextEditingController _transmissionController;
  late TextEditingController _luggageCapacityController;
  late TextEditingController _featuresController;
  late TextEditingController _fuelTypeController;
  late TextEditingController _fuelConsumptionController;

  @override
  void initState() {
    super.initState();
    _getUsername();

    // Initialize controllers
    _brandController = TextEditingController(text: widget.car['brand']);
    _modelController = TextEditingController(text: widget.car['model']);
    _priceController = TextEditingController(
      text: widget.car['price'].toString(),
    );
    _categoryController = TextEditingController(text: widget.car['category']);
    _capacityController = TextEditingController(text: widget.car['capacity']);
    _transmissionController = TextEditingController(
      text: widget.car['transmission'],
    );
    _luggageCapacityController = TextEditingController(
      text: widget.car['lunggage_capacity'],
    );
    _featuresController = TextEditingController(text: widget.car['features']);
    _fuelTypeController = TextEditingController(text: widget.car['fuel_type']);
    _fuelConsumptionController = TextEditingController(
      text: widget.car['fuel_consumption'],
    );
  }

  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
    });
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _capacityController.dispose();
    _transmissionController.dispose();
    _luggageCapacityController.dispose();
    _featuresController.dispose();
    _fuelTypeController.dispose();
    _fuelConsumptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.fifthColor,
      appBar: AppBar(
        title: Text('Detail Mobil', style: TextStyle(color: Warna.thirdColor)),
        backgroundColor: Warna.fifthColor,
        foregroundColor: Warna.thirdColor,
        actions: [
          if (_username == 'admin')
            IconButton(
              onPressed: () {
                _showEditDialog(context);
              },
              icon: Icon(Icons.edit, color: Warna.thirdColor),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70, left: 30, right: 30),
                  child: Center(
                    child: Image.network(
                      widget.car['image_url'] ??
                          'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Warna.thirdColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30),
                    width: double.infinity,
                    child: Text(
                      '${widget.car['brand']} ${widget.car['model']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text(
                              'Rp.${widget.car['price']}',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        ' / 1 hari',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: Row(
                        children: List.generate(7, (index) {
                          Icon iconSpesifikasi;
                          String judulSpesifikasi;
                          String keteranganSpesifikasi;

                          switch (index) {
                            case 0:
                              iconSpesifikasi = Icon(
                                Icons.car_crash,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Kategori';
                              keteranganSpesifikasi =
                                  '${widget.car['category']}';
                              break;
                            case 1:
                              iconSpesifikasi = Icon(
                                Icons.airline_seat_recline_extra,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Kapasitas';
                              keteranganSpesifikasi =
                                  '${widget.car['capacity']} Orang';
                              break;
                            case 2:
                              iconSpesifikasi = Icon(
                                Icons.grid_goldenratio,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Transmisi';
                              keteranganSpesifikasi =
                                  '${widget.car['transmission']}';
                              break;
                            case 3:
                              iconSpesifikasi = Icon(
                                Icons.luggage,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Bagasi';
                              keteranganSpesifikasi =
                                  '${widget.car['lunggage_capacity']}';
                              break;
                            case 4:
                              iconSpesifikasi = Icon(
                                Icons.star,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Fitur';
                              keteranganSpesifikasi =
                                  '${widget.car['features']}';
                              break;
                            case 5:
                              iconSpesifikasi = Icon(
                                Icons.door_back_door,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Bahan Bakar';
                              keteranganSpesifikasi =
                                  '${widget.car['fuel_type']}';
                              break;
                            case 6:
                              iconSpesifikasi = Icon(
                                Icons.ac_unit,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Konsumsi';
                              keteranganSpesifikasi =
                                  '${widget.car['fuel_consumption']}';
                              break;
                            default:
                              iconSpesifikasi = Icon(Icons.ac_unit);
                              judulSpesifikasi = 'Kapasitas';
                              keteranganSpesifikasi = '4 Orang';
                          }

                          return Container(
                            height: 130,
                            width: 130,
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: Warna.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                iconSpesifikasi,
                                const SizedBox(height: 15),
                                Text(
                                  judulSpesifikasi,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  keteranganSpesifikasi,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    color: Warna.primaryColor,
                    margin: EdgeInsets.only(bottom: 25, left: 30, right: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PembayaranScreen(widget.car),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(400, 50),
                        backgroundColor: Colors.yellow,
                      ),
                      child: Text(
                        "Rental Sekarang",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Data'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Brand', _brandController),
                _buildTextField('Model', _modelController),
                _buildTextField('Price', _priceController, isNumeric: true),
                _buildTextField('Category', _categoryController),
                _buildTextField('Capacity', _capacityController),
                _buildTextField('Transmission', _transmissionController),
                _buildTextField('Luggage Capacity', _luggageCapacityController),
                _buildTextField('Features', _featuresController),
                _buildTextField('Fuel Type', _fuelTypeController),
                _buildTextField('Fuel Consumption', _fuelConsumptionController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget.car['brand'] = _brandController.text;
                  widget.car['model'] = _modelController.text;
                  widget.car['price'] =
                      int.tryParse(_priceController.text) ??
                      widget.car['price'];
                  widget.car['category'] = _categoryController.text;
                  widget.car['capacity'] = _capacityController.text;
                  widget.car['transmission'] = _transmissionController.text;
                  widget.car['lunggage_capacity'] =
                      _luggageCapacityController.text;
                  widget.car['features'] = _featuresController.text;
                  widget.car['fuel_type'] = _fuelTypeController.text;
                  widget.car['fuel_consumption'] =
                      _fuelConsumptionController.text;
                });

                _saveCarDataToApi();
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _saveCarDataToApi();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumeric = false,
  }) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    );
  }

  Future<void> _saveCarDataToApi() async {
    final url = 'http://10.0.2.2:8000/cars/${widget.car['id']}';

    final Map<String, dynamic> requestData = {
      'category': _categoryController.text,
      'brand': _brandController.text,
      'model': _modelController.text,
      'price': int.tryParse(_priceController.text) ?? widget.car['price'],
      'capacity': _capacityController.text,
      'transmission': _transmissionController.text,
      'lunggage_capacity': _luggageCapacityController.text,
      'features': _featuresController.text,
      'fuel_type': _fuelTypeController.text,
      'fuel_consumption': _fuelConsumptionController.text,
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        print('Data berhasil dikirim: ${response.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Data berhasil disimpan.'),
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
              content: Text(
                'Gagal mengirim data.\nKode status: ${response.statusCode}\nPesan: ${response.body}',
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
    } catch (e) {
      print('Terjadi kesalahan: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan: $e'),
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
}
