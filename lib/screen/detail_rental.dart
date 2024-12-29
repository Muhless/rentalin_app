import 'package:flutter/material.dart';
import 'package:rentalin_app/screen/widgets/warna.dart';

class DetailRentalScreen extends StatefulWidget {
  final dynamic transaksi;

  const DetailRentalScreen({super.key, required this.transaksi});

  @override
  // ignore: library_private_types_in_public_api
  _DetailRentalScreenState createState() => _DetailRentalScreenState();
}

class _DetailRentalScreenState extends State<DetailRentalScreen> {
  final bool _isLoading = false;
  late bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkIfAdmin();
  }

  void _checkIfAdmin() {
    setState(() {
      _isAdmin = true;
    });
  }

  Future<void> _updateStatus(BuildContext context) async {
    String? newStatus = await showDialog(
      context: context,
      builder: (context) {
        String? selectedStatus;
        return AlertDialog(
          title: Text('Ubah Status'),
          content: DropdownButtonFormField<String>(
            items:
                ['Sedang Berlangsung', 'Selesai', 'Dibatalkan']
                    .map(
                      (status) =>
                          DropdownMenuItem(value: status, child: Text(status)),
                    )
                    .toList(),
            onChanged: (value) {
              selectedStatus = value;
            },
            hint: Text('Pilih Status Baru'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedStatus);
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (newStatus != null) {
      // ignore: avoid_print
      print('Status baru: $newStatus');
      setState(() {
        widget.transaksi['status'] = newStatus;
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status berhasil diubah menjadi $newStatus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final transaksi = widget.transaksi;

    return Scaffold(
      backgroundColor: Warna.primaryColor,
      appBar: AppBar(
        title: Text('Detail Transaksi'),
        backgroundColor: Warna.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          if (_isAdmin)
            IconButton(
              onPressed: () => _updateStatus(context),
              icon: Icon(Icons.edit),
              tooltip: 'Ubah Status',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildDetailRow('Nama', '${transaksi['users']}'),
                      SizedBox(height: 10),
                      _buildDetailRow('Mobil', '${transaksi['cars']}'),
                      SizedBox(height: 10),
                      _buildDetailRow(
                        'Tanggal Perentalan',
                        '${transaksi['rent_date']}',
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow(
                        'Tanggal Pengembalian',
                        '${transaksi['return_date']}',
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow(
                        'Durasi Rental',
                        '${transaksi['rent_duration']} days',
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow(
                        'Metode Pembayaran',
                        '${transaksi['payment']}',
                      ),
                      SizedBox(height: 10),
                      _buildDetailRow('Total', 'Rp ${transaksi['total']}'),
                      SizedBox(height: 10),
                      _buildDetailRow('Status', '${transaksi['status']}'),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Warna.fifthColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
