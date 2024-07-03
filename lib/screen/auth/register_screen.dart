// register_page.dart
import 'package:flutter/material.dart';
import 'package:ujidatapanen/controller/user/register_controller.dart';
import 'package:ujidatapanen/screen/login_screen.dart';
import 'package:ujidatapanen/widget/app_bar_wave.dart';
import 'package:ujidatapanen/widget/register_form.dart';
import 'package:ujidatapanen/widget/navigation_buttons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _registerController = RegisterController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isRegisterTextButtonHovered = true;
  bool isRegistered = false;

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWave(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NavigationButtons(
                navigateToLogin: _navigateToLogin,
                isRegisterTextButtonHovered: isRegisterTextButtonHovered,
              ),
              const SizedBox(height: 10),
              RegisterForm(
                registerController: _registerController,
                formKey: _formKey,
                usernameController: usernameController,
                alamatController: alamatController,
                noTelpController: noTelpController,
                emailController: emailController,
                passwordController: passwordController,
                isRegistered: isRegistered,
                navigateToLogin: _navigateToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
