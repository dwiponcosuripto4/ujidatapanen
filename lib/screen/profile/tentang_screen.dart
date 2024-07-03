import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ujidatapanen/widget/info_row.dart';

class TentangView extends StatefulWidget {
  @override
  _TentangViewState createState() => _TentangViewState();
}

class _TentangViewState extends State<TentangView> {
  String _username = '';
  String _email = '';
  String _tanggalBergabung = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _email = prefs.getString('email') ?? '';
      _tanggalBergabung = prefs.getString('tanggalBergabung') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A4D2E),
        title: Text(
          'Tentang',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali normal
          },
        ),
      ),
      backgroundColor: Color(0xFF1A4D2E),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            height: 300,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF00695C),
                  Color(0xFF00695C),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TentangMu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  InfoRow(icon: Icons.account_circle, label: 'Username', value: _username),
                  SizedBox(height: 12),
                  InfoRow(icon: Icons.email, label: 'Email', value: _email),
                  SizedBox(height: 12),
                  InfoRow(icon: Icons.date_range, label: 'Tanggal Bergabung', value: _tanggalBergabung),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
