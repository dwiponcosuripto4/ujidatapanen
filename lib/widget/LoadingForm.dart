// loading_form.dart
import 'package:flutter/material.dart';

class LoadingForm extends StatelessWidget {
  final TextEditingController namaLoadingController;
  final TextEditingController pemilikController;
  final TextEditingController alamatController;
  final TextEditingController lokasiController;

  const LoadingForm({
    Key? key,
    required this.namaLoadingController,
    required this.pemilikController,
    required this.alamatController,
    required this.lokasiController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: namaLoadingController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Nama Loading',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextFormField(
          controller: pemilikController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Pemilik',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextFormField(
          controller: alamatController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Alamat',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextFormField(
          controller: lokasiController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Lokasi',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
