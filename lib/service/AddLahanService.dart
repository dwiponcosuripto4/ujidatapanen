import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/lahan.dart';

class LahanService {
  Future<bool> createLahan(Lahan lahan) async {
    var url = Uri.parse('http://192.168.0.101/tani/lahan.php');
    var response = await http.post(url, body: {
      'nama_lahan': lahan.namaLahan,
      'lokasi': lahan.lokasi,
      'luas': lahan.luas.toString(),
      'user_id': lahan.userId.toString(),
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        return true;
      } else {
        throw Exception(jsonResponse['message']);
      }
    } else {
      throw Exception('Gagal terhubung ke server');
    }
  }
}
