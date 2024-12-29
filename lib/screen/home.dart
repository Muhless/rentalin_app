// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/auth/login.dart';
import 'package:rentalin_app/screen/help.dart';
import 'package:rentalin_app/screen/list.dart';
import 'package:rentalin_app/screen/profile.dart';
import 'package:rentalin_app/screen/rental.dart';
import 'package:rentalin_app/screen/widgets/statusbar.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }


  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('username');
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemUIHelper.setTransparentStatusBar(iconBrightness: Brightness.light);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Warna.primaryColor,
          image: DecorationImage(
            image: AssetImage("assets/bg2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 88, left: 30, right: 30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Halo,',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout, size: 20, color: Colors.white),
                        onPressed: () {
                          _logout(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(1, (index) {
                    String judulSpesifikasi;
                    String tagline;

                    switch (index) {
                      case 0:
                        judulSpesifikasi = 'Pilihan Terbaik ';
                        tagline = 'untuk Setiap Perjalanan';
                        break;

                      default:
                        judulSpesifikasi = 'Kapasitas';
                        tagline = 'cihuy';
                    }
                    return GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListCarScreen(),
                              ),
                            );
                        }
                      },
                      child: Container(
                        height: 200,
                        width: 320,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bg1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          color: Warna.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Text(
                                judulSpesifikasi,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Warna.primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              tagline,
                              style: TextStyle(
                                fontSize: 17,
                                color: Warna.primaryColor,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20, top: 10),
                              height: 30,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Warna.thirdColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rental Sekarang",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(2, (index) {
                      Icon iconSpesifikasi;
                      String judulSpesifikasi;

                      switch (index) {
                        case 0:
                          iconSpesifikasi = Icon(
                            Icons.list_alt,
                            size: 40,
                            color: Colors.white,
                          );
                          judulSpesifikasi = 'Rental';
                          break;
                        case 1:
                          iconSpesifikasi = Icon(
                            Icons.car_crash,
                            size: 40,
                            color: Colors.white,
                          );
                          judulSpesifikasi = 'Daftar Mobil';
                          break;
                        default:
                          iconSpesifikasi = Icon(Icons.ac_unit);
                          judulSpesifikasi = 'Kapasitas';
                      }

                      return GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RentalScreen(),
                                ),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListCarScreen(),
                                ),
                              );
                              break;
                            default:
                              Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 130,
                          width: 130,
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
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(2, (index) {
                      Icon iconSpesifikasi;
                      String judulSpesifikasi;

                      switch (index) {
                        case 0:
                          iconSpesifikasi = Icon(
                            Icons.history,
                            size: 40,
                            color: Colors.white,
                          );
                          judulSpesifikasi = 'Profil';
                          break;
                        case 1:
                          iconSpesifikasi = Icon(
                            Icons.help_center,
                            size: 40,
                            color: Colors.white,
                          );
                          judulSpesifikasi = 'Bantuan';
                          break;
                        default:
                          iconSpesifikasi = Icon(Icons.ac_unit);
                          judulSpesifikasi = 'Home';
                      }

                      return GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen()
                                ),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerserviceScreen(),
                                ),
                              );
                              break;
                            default:
                              Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: 130,
                          width: 130,
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
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
