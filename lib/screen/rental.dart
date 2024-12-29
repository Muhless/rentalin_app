import 'package:flutter/material.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({super.key});

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Halaman Rental')));
  }
}
