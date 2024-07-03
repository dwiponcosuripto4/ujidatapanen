import 'package:flutter/material.dart';

class SaldoDisplay extends StatelessWidget {
  final double totalPanen;
  final double pendapatan;
  final bool isTotalPanenVisible;
  final bool isPendapatanVisible;
  final VoidCallback onToggleTotalPanenVisibility;
  final VoidCallback onTogglePendapatanVisibility;

  SaldoDisplay({
    required this.totalPanen,
    required this.pendapatan,
    required this.isTotalPanenVisible,
    required this.isPendapatanVisible,
    required this.onToggleTotalPanenVisibility,
    required this.onTogglePendapatanVisibility,
  });

  @override
  Widget build(BuildContext context) {
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
            onTap: onToggleTotalPanenVisibility,
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
            onTap: onTogglePendapatanVisibility,
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
}
