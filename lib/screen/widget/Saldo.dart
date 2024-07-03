import 'package:flutter/material.dart';

class TotalPanenPendapatan extends StatelessWidget {
  final Future<Map<String, dynamic>> saldoFuture;
  final bool isPendapatanVisible;
  final bool isTotalPanenVisible;
  final Function onPendapatanVisibilityToggle;
  final Function onTotalPanenVisibilityToggle;

  TotalPanenPendapatan({
    required this.saldoFuture,
    required this.isPendapatanVisible,
    required this.isTotalPanenVisible,
    required this.onPendapatanVisibilityToggle,
    required this.onTotalPanenVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: saldoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('Loading...');
        } else {
          double totalPanen = (snapshot.data!['total_panen'] ?? 0).toDouble();
          double pendapatan = (snapshot.data!['pendapatan'] ?? 0).toDouble();

          return Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Panen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        AnimatedOpacity(
                          opacity: isTotalPanenVisible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            '${totalPanen.toStringAsFixed(2)} Kg',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => onTotalPanenVisibilityToggle(),
                  child: Icon(
                    isTotalPanenVisible
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pendapatan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        AnimatedOpacity(
                          opacity: isPendapatanVisible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            'Rp ${pendapatan.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => onPendapatanVisibilityToggle(),
                  child: Icon(
                    isPendapatanVisible
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
