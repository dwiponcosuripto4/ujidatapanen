import 'package:flutter/material.dart';
import 'package:ujidatapanen/controller/user/login_controller.dart';
import 'package:ujidatapanen/screen/auth/register_screen.dart';
import 'package:ujidatapanen/screen/home.dart';
import 'package:ujidatapanen/widget/email_input_field.dart';
import 'package:ujidatapanen/widget/password_input_field.dart';
import 'package:ujidatapanen/widget/wave_clipper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _loginController;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';

  bool isRegisterTextButtonHovered = false;
  bool isLoginTextButtonHovered = true; // Default to true for Login Screen

  @override
  void initState() {
    _loginController = LoginController();
    super.initState();
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(),
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(210),
        child: ClipPath(
          clipper: WaveClipper(),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Tani Jaya',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(39, 246, 56, 0.824),
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(39, 246, 56, 0.824),
                    Color.fromRGBO(29, 201, 52, 0.824),
                    Color.fromRGBO(19, 157, 47, 0.824),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle Login button tap
                      },
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isLoginTextButtonHovered = true;
                            isRegisterTextButtonHovered = false;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            isLoginTextButtonHovered = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!isRegisterTextButtonHovered)
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                height: 2,
                                width: 60,
                                color: Colors.green,
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 100),
                    GestureDetector(
                      onTap: () {
                        _navigateToRegister(context);
                      },
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isRegisterTextButtonHovered = true;
                            isLoginTextButtonHovered = false;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            isRegisterTextButtonHovered = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: isRegisterTextButtonHovered
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                color: isRegisterTextButtonHovered
                                    ? Color.fromARGB(255, 92, 227, 96)
                                    : Colors.black,
                              ),
                            ),
                            if (isRegisterTextButtonHovered)
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                height: 2,
                                width: 60,
                                color: Colors.green,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                EmailInputField(controller: emailController),
                const SizedBox(height: 20),
                PasswordInputField(controller: passwordController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = emailController.text;
                      String password = passwordController.text;
                      int? userId = await _loginController.login(
                        context,
                        email,
                        password,
                      );
                      if (userId != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeView(userId: userId),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 92, 227, 96),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 150,
                      vertical: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}