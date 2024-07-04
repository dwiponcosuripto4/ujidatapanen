import 'package:flutter/material.dart';
import 'package:ujidatapanen/model/lahan.dart';
import 'package:ujidatapanen/service/lahan/AddLahanService.dart';

class LahanController {
  final LahanService _lahanService = LahanService();

  Future<bool> createLahan(BuildContext context, Lahan lahan) async {
    if (!_validateLahan(lahan)) {
      // Jika validasi gagal, tampilkan pesan error dan kembalikan false
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data lahan tidak lengkap atau tidak valid'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    try {
      bool createSuccess = await _lahanService.createLahan(lahan);
      if (createSuccess) {
        // Jika pembuatan lahan berhasil, lakukan tindakan sesuai kebutuhan seperti navigasi atau menampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pembuatan lahan berhasil'),
          backgroundColor: Colors.green,
        ));
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pembuatan lahan gagal'),
          backgroundColor: Colors.red,
        ));
        return false;
      }
    } catch (e) {
      // Jika terjadi kesalahan, tangani error sesuai kebutuhan seperti menampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }

  bool _validateLahan(Lahan lahan) {
    // Tambahkan validasi sesuai kebutuhan
    // Contoh validasi sederhana:
    if (lahan.namaLahan == null || lahan.namaLahan!.isEmpty) {
      return false;
    }
    if (lahan.luas == null || lahan.luas! <= 0) {
      return false;
    }
    // Tambahkan validasi untuk field lain sesuai kebutuhan
    // Misalnya:
    // if (lahan.alamat == null || lahan.alamat!.isEmpty) {
    //   return false;
    // }
    return true;
  }
}