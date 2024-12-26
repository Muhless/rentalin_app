// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/mobil/family/detail.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class ListFamily extends StatefulWidget {
  const ListFamily({super.key});

  @override
  State<ListFamily> createState() => _MobilKeluargaState();
}

class _MobilKeluargaState extends State<ListFamily> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  Color _textColor = Colors.white;

  void _search(String query) {
    print("Mencari: $query");
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _textColor = _focusNode.hasFocus ? Colors.black : Colors.white;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Warna.sixthColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              _focusNode.hasFocus
                                  ? Warna.fifthColor
                                  : Colors.transparent,
                          border: Border.all(
                            color:
                                _focusNode.hasFocus
                                    ? Colors.white
                                    : Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextField(
                          focusNode: _focusNode,
                          controller: _controller,
                          style: TextStyle(color: _textColor),
                          onChanged: (value) {
                            print('Teks pencarian: $value');
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari mobil',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                _search(_controller.text);
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailFamily(),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 190,
                        decoration: BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Image.asset(
                                          'assets/icons/toyota.png',
                                          height: 50,
                                          width: 100,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Toyota',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Avanza',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        'assets/family/brio.png',
                                        height: 130,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Container(
                                  // margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.airline_seat_recline_extra,
                                              size: 13,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              '4 Kursi',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.grid_goldenratio,
                                              size: 13,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              'Manual',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 13,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          'Rp150.000/hari',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // batas list
    //
  }
}
