// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/auth/button.dart';
import 'package:rentalin_app/screen/auth/login.dart';
import 'package:rentalin_app/screen/services/auth_services.dart';
import 'package:rentalin_app/screen/services/globals.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePassword = true;
  String _name = '';
  String _email = '';
  String _password = '';

  createAccountPress() async {
    bool emailValid = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(_email);
    if (emailValid) {
      Map<String, dynamic> response = await AuthServices.register(
        _name,
        _email,
        _password,
      );
      if (response['status'] == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        errorSnackBar(context, response.values.first[0]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Warna.fourthColor,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Silahkan register terlebih dahulu sebelum login',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        SizedBox(height: 32),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'name',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'email',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            _email = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextField(
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonSubmit(
                            btnText: 'Buat Akun',
                            onBtnPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Sudah punya akun? ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextSpan(
                                    text: ' disini',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => const Login(),
                                              ),
                                            );
                                          },
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }
}
