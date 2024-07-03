import 'package:flutter/material.dart';
import 'package:ujidatapanen/controller/lahan/AddLahanController.dart';
import 'package:ujidatapanen/model/lahan.dart';

class LahanButton extends StatelessWidget {
  final LahanController lahanController;
  final TextEditingController namaLahanController;
  final TextEditingController lokasiController;
  final TextEditingController luasController;
  final int userId;

  const LahanButton({
    Key? key,
    required this.lahanController,
    required this.namaLahanController,
    required this.lokasiController,
    required this.luasController,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String namaLahan = namaLahanController.text;
        String lokasi = lokasiController.text;
        int luas = int.tryParse(luasController.text) ?? 0;
        Lahan lahan = Lahan(
          id: 0, // id akan di-generate oleh database (auto increment)
          namaLahan: namaLahan,
          lokasi: lokasi,
          luas: luas,
          userId: userId, // Menggunakan userId dari Provider
        );
        bool createSuccess = await lahanController.createLahan(context, lahan);
        if (createSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lahan berhasil ditambahkan'),
              duration: Duration(seconds: 5),
              backgroundColor: Colors.blue,
            ),
          );
          Navigator.pop(context, true); // Kembali ke halaman HomeView
        }
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size(250, 50)),
      ),
      child: const Text('Tambah Lahan', style: TextStyle(fontSize: 18)),
    );
  }
}
