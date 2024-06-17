import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  Future<int?> login(String email, String password) async {
    var url = Uri.parse('http://192.168.0.101/tani/login.php');
    var response = await http.post(url, body: {
      'action': 'login',
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        // Pastikan user_id ada di respons dan dikembalikan sebagai int
        return int.tryParse(jsonResponse['user_id'].toString());
      } else {
        throw Exception(jsonResponse['message']);
      }
    } else {
      throw Exception('Failed to connect to the server');
    }
  }
}
