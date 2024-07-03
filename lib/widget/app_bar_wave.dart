// widget/app_bar_wave.dart
import 'package:flutter/material.dart';
import 'wave_clipper.dart';

class AppBarWave extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWave({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(210);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
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
    );
  }
}
