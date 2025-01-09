// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/pembayaran.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class DetailCarScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const DetailCarScreen(this.car, {super.key});

  @override
  State<DetailCarScreen> createState() => _DetailCarScreen();
}

class _DetailCarScreen extends State<DetailCarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.fifthColor,
      appBar: AppBar(
        title: Text('Detail Mobil', style: TextStyle(color: Warna.thirdColor)),
        backgroundColor: Warna.fifthColor,
        foregroundColor: Warna.thirdColor,
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
                      fit: BoxFit.fill,
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
                        children: List.generate(6, (index) {
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
                                  '${widget.car['capacity']}';
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
                                  '${widget.car['luggage_capacity']}';
                              break;

                            case 4:
                              iconSpesifikasi = Icon(
                                Icons.local_gas_station_rounded,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Bahan Bakar';
                              keteranganSpesifikasi =
                                  '${widget.car['fuel_type']}';
                              break;
                            case 5:
                              iconSpesifikasi = Icon(
                                Icons.gesture,
                                size: 40,
                                color: Colors.white,
                              );
                              judulSpesifikasi = 'Konsumsi';
                              keteranganSpesifikasi =
                                  '${widget.car['fuel_consumption']} ltr/km';
                              break;
                            default:
                              iconSpesifikasi = Icon(Icons.gesture_sharp);
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
                                    fontSize: 18,
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
}
