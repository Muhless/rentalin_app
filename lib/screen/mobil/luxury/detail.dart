// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentalin_app/screen/pembayaran.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class DetailLuxury extends StatefulWidget {
  const DetailLuxury({super.key});

  @override
  State<DetailLuxury> createState() => _DetailLuxury();
}

class _DetailLuxury extends State<DetailLuxury> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Warna.fifthColor,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 38, left: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Warna.secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70, left: 30, right: 30),
                    child: Center(
                      child: Image.asset(
                        'assets/luxury/audi.png',
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
                color: Warna.secondaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 30),
                      width: double.infinity,
                      child: Text(
                        '#Nama Mobil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            'Rp150.000',
                            style: TextStyle(
                              color: Warna.primaryColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text('/12 jam', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: Row(
                          children: List.generate(4, (index) {
                            Icon iconSpesifikasi;
                            String judulSpesifikasi;
                            String keteranganSpesifikasi;

                            switch (index) {
                              case 0:
                                iconSpesifikasi = Icon(
                                  Icons.airline_seat_recline_extra,
                                  size: 40,
                                  color: Colors.white,
                                );
                                judulSpesifikasi = 'Kapasitas';
                                keteranganSpesifikasi = '4 Orang';
                                break;
                              case 1:
                                iconSpesifikasi = Icon(
                                  Icons.grid_goldenratio,
                                  size: 40,
                                  color: Colors.white,
                                );
                                judulSpesifikasi = 'Type';
                                keteranganSpesifikasi = 'Manual';
                                break;
                              case 2:
                                iconSpesifikasi = Icon(
                                  Icons.door_back_door,
                                  size: 40,
                                  color: Colors.white,
                                );
                                judulSpesifikasi = 'Kapasitas';
                                keteranganSpesifikasi = '4 Orang';
                                break;
                              case 3:
                                iconSpesifikasi = Icon(
                                  Icons.ac_unit,
                                  size: 40,
                                  color: Colors.white,
                                );
                                judulSpesifikasi = 'Kapasitas';
                                keteranganSpesifikasi = '4 Orang';
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
                                color: Warna.thirdColor,
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
                    SizedBox(height: 10),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
