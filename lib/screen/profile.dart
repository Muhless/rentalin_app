import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController carIdController = TextEditingController();
  TextEditingController rentDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController rentDurationController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  Future<void> _sendDataToApi() async {
    const String apiUrl =
        'http://10.0.2.2:8000/api/transactions'; 
    final Map<String, dynamic> requestData = {
      'users': usernameController.text,
      'cars': carIdController.text,
      'rent_date': rentDateController.text,
      'return_date': returnDateController.text,
      'rent_duration': rentDurationController.text,
      'payment': paymentController.text,
      'total': int.parse(totalController.text),
      'status': statusController.text,
    };

    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        // Jika berhasil
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data berhasil dikirim!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengirim data'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: carIdController,
              decoration: InputDecoration(labelText: 'Car ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: rentDateController,
              decoration: InputDecoration(labelText: 'Rent Date (yyyy-mm-dd)'),
            ),
            TextField(
              controller: returnDateController,
              decoration: InputDecoration(
                labelText: 'Return Date (yyyy-mm-dd)',
              ),
            ),
            TextField(
              controller: rentDurationController,
              decoration: InputDecoration(labelText: 'Rent Duration (in days)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: paymentController,
              decoration: InputDecoration(labelText: 'Payment Method'),
            ),
            TextField(
              controller: totalController,
              decoration: InputDecoration(labelText: 'Total Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                  onPressed: _sendDataToApi,
                  child: Text('Submit Transaction'),
                ),
          ],
        ),
      ),
    );
  }
}
