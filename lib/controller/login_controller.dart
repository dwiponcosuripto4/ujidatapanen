// login_controller.dart
import 'package:flutter/material.dart';
import 'package:ujidatapanen/screen/home.dart';
import 'package:ujidatapanen/service/login_service.dart';

class LoginController {
  final LoginService _loginService = LoginService();

  Future<int?> login(
      BuildContext context, String email, String password) async {
    try {
      bool loginSuccess = await _loginService.login(email, password);
      if (loginSuccess) {
        // Dapatkan userId dari hasil login atau permintaan ke server
        int userId = 21; // Contoh userId dari hasil login
        return userId;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return null;
  }
}
