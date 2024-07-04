import 'dart:convert';
import 'package:http/http.dart' as http;

class LahanService {
  static const String baseUrl = "http://192.168.98.93/tani/delete_lahan.php";

  Future<void> deleteLahan(int id) async {
    try {
      var url = Uri.parse('$baseUrl?id=$id');
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse['message']);
      } else {
        throw Exception('Gagal menghapus lahan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
