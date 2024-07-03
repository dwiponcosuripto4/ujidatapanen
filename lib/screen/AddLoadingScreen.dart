// add_loading_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ujidatapanen/controller/AddLoadingController.dart';
import 'package:ujidatapanen/model/loading.dart';
import 'package:ujidatapanen/provider/AuthProvider.dart';
import 'package:ujidatapanen/screen/widget/LoadingForm.dart';
import 'package:ujidatapanen/screen/widget/LocationPicker.dart';

class AddLoadingScreen extends StatefulWidget {
  const AddLoadingScreen({Key? key}) : super(key: key);

  @override
  _AddLoadingScreenState createState() => _AddLoadingScreenState();
}

class _AddLoadingScreenState extends State<AddLoadingScreen> {
  final LoadingController _loadingController = LoadingController();
  final TextEditingController namaLoadingController = TextEditingController();
  final TextEditingController pemilikController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  String? _lokasi;

  @override
  Widget build(BuildContext context) {
    int userId = Provider.of<AuthProvider>(context, listen: false).userId ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A4D2E),
        title: const Text(
          'Tambah Loading',
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
            LoadingForm(
              namaLoadingController: namaLoadingController,
              pemilikController: pemilikController,
              alamatController: alamatController,
            ),
            const SizedBox(height: 20),
            LocationPicker(
              onLocationSelected: (selectedLocation) {
                setState(() {
                  _lokasi = selectedLocation;
                });
              },
              selectedLocation: _lokasi,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String namaLoading = namaLoadingController.text;
                String pemilik = pemilikController.text;
                String alamat = alamatController.text;
                String lokasi = _lokasi ?? '';

                if (lokasi.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lokasi harus dipilih'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Loading loading = Loading(
                  id: 0, // id akan di-generate oleh database (auto increment)
                  namaLoading: namaLoading,
                  pemilik: pemilik,
                  alamat: alamat,
                  lokasi: lokasi,
                  userId: userId,
                );
                bool createSuccess =
                    await _loadingController.createLoading(context, loading);
                if (createSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Loading berhasil ditambahkan'),
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.blue,
                    ),
                  );
                  Navigator.pop(context, true); // Kembali ke ViewLoadingScreen dengan nilai true
                }
              },
              child: const Text('Tambah Loading'),
            ),
          ],
        ),
      ),
    );
  }
}
