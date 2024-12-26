import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentalin_app/screen/services/globals.dart';

class AuthServices {
  static Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      var url = Uri.parse(baseURL + 'auth/register');
      var response = await http.post(url,
          headers: headers,
          body: json.encode({
            'name': name,
            'email': email,
            'password': password,
          }));

      // Cek status code
      if (response.statusCode == 200) {
        return json.decode(response.body); // Mengembalikan body response yang sudah di-decode
      } else {
        throw Exception('Failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
      rethrow; // Melempar kembali exception agar bisa ditangani di tempat lain
    }
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      var url = Uri.parse(baseURL + 'auth/login');
      var response = await http.post(url,
          headers: headers,
          body: json.encode({
            'email': email,
            'password': password,
          }));

      // Cek status code
      if (response.statusCode == 200) {
        return json.decode(response.body); // Mengembalikan body response yang sudah di-decode
      } else {
        throw Exception('Failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      rethrow; // Melempar kembali exception agar bisa ditangani di tempat lain
    }
  }
}
