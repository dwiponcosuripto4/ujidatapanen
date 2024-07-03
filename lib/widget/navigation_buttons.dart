// widget/navigation_buttons.dart
import 'package:flutter/material.dart';
import 'package:ujidatapanen/screen/login_screen.dart';

class NavigationButtons extends StatefulWidget {
  final Function(BuildContext context) navigateToLogin;
  final bool isRegisterTextButtonHovered;

  const NavigationButtons({
    Key? key,
    required this.navigateToLogin,
    required this.isRegisterTextButtonHovered,
  }) : super(key: key);

  @override
  _NavigationButtonsState createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            widget.navigateToLogin(context);
          },
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                // Update hover state
              });
            },
            onExit: (_) {
              setState(() {
                // Update hover state
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
              ],
            ),
          ),
        ),
        SizedBox(width: 100),
        GestureDetector(
          onTap: () {},
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                // Update hover state
              });
            },
            onExit: (_) {
              setState(() {
                // Update hover state
              });
            },
            child: Column(
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.isRegisterTextButtonHovered)
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
    );
  }
}
