// widget/register_form.dart
import 'package:flutter/material.dart';
import 'package:ujidatapanen/controller/user/register_controller.dart';
import 'package:ujidatapanen/model/user.dart';
import 'package:ujidatapanen/screen/login_screen.dart';

class RegisterForm extends StatefulWidget {
  final RegisterController registerController;
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController alamatController;
  final TextEditingController noTelpController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isRegistered;
  final Function(BuildContext context) navigateToLogin;

  const RegisterForm({
    Key? key,
    required this.registerController,
    required this.formKey,
    required this.usernameController,
    required this.alamatController,
    required this.noTelpController,
    required this.emailController,
    required this.passwordController,
    required this.isRegistered,
    required this.navigateToLogin,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: widget.usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.person),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.alamatController,
            decoration: InputDecoration(
              labelText: 'Alamat',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.home),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.noTelpController,
            decoration: InputDecoration(
              labelText: 'Nomor Telepon',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.phone),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.email),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.lock),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: widget.isRegistered
                ? null // Disable button when registered
                : () async {
                    if (widget.formKey.currentState!.validate()) {
                      String username = widget.usernameController.text;
                      String alamat = widget.alamatController.text;
                      int noTelp =
                          int.tryParse(widget.noTelpController.text) ?? 0;
                      String email = widget.emailController.text;
                      String password = widget.passwordController.text;
                      User user = User(
                        id: 0,
                        username: username,
                        alamat: alamat,
                        no_telp: noTelp,
                        email: email,
                        password: password,
                      );
                      bool registerSuccess = await widget
                          .registerController
                          .registerUser(context, user);
                      if (registerSuccess) {
                        setState(() {
                          // Set registration status
                        });
                        // Optionally show success message or navigate
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registration successful!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        // Navigate to login page or perform other actions
                        widget.navigateToLogin(context);
                      } else {
                        // Handle registration failure if needed
                        setState(() {
                          errorMessage =
                              'Registration failed. Please try again.';
                        });
                      }
                    }
                  },
            child: const Text('Register'),
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
    );
  }
}
