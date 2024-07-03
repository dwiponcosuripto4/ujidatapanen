import 'package:flutter/material.dart';

class LahanForm extends StatelessWidget {
  final TextEditingController namaLahanController;
  final TextEditingController lokasiController;
  final TextEditingController luasController;

  const LahanForm({
    Key? key,
    required this.namaLahanController,
    required this.lokasiController,
    required this.luasController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: namaLahanController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Nama Lahan',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        TextFormField(
          controller: lokasiController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Lokasi',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        TextFormField(
          controller: luasController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Luas',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
