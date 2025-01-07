import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/home.dart';
import 'package:rentalin_app/screen/auth/login.dart';
import 'package:rentalin_app/screen/rental.dart';
import 'package:rentalin_app/screen/widgets/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/rental': (context) => const RentalScreen(),
      },
    );
  }
}
