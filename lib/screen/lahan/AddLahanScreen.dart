import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujidatapanen/controller/lahan/AddLahanController.dart';
import 'package:ujidatapanen/model/lahan.dart';
import 'package:ujidatapanen/provider/AuthProvider.dart';
import 'package:ujidatapanen/widget/lahan_button.dart';
import 'package:ujidatapanen/widget/lahan_form.dart';
import 'package:ujidatapanen/widget/location_input.dart';

class LahanScreen extends StatefulWidget {
  const LahanScreen({Key? key}) : super(key: key);

  @override
  _LahanScreenState createState() => _LahanScreenState();
}

class _LahanScreenState extends State<LahanScreen> {
  final LahanController _lahanController = LahanController();
  TextEditingController namaLahanController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController luasController = TextEditingController();
  String? _lokasi;

  @override
  Widget build(BuildContext context) {
    int userId = Provider.of<AuthProvider>(context, listen: false).userId ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A4D2E),
        title: const Text(
          'Tambah Lahan',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali normal
          },
        ),
      ),
      backgroundColor: const Color(0xFF1A4D2E),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LahanForm(
              namaLahanController: namaLahanController,
              lokasiController: lokasiController,
              luasController: luasController,
            ),
            LocationInput(
              lokasi: _lokasi,
              onLocationSelected: (selectedLocation) {
                setState(() {
                  _lokasi = selectedLocation;
                  lokasiController.text = selectedLocation;
                });
              },
            ),
            const SizedBox(height: 20),
            LahanButton(
              lahanController: _lahanController,
              namaLahanController: namaLahanController,
              lokasiController: lokasiController,
              luasController: luasController,
              userId: userId,
            ),
          ],
        ),
      ),
    );
  }
}
