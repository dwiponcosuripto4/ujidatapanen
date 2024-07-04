import 'package:flutter/material.dart';
import 'package:ujidatapanen/model/lahan.dart';
import 'package:ujidatapanen/screen/lahan/ViewLahanDetail.dart';

class LahanListItem extends StatelessWidget {
  final Lahan lahan;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  LahanListItem(
      {required this.lahan, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      height: 80,
      child: Opacity(
        opacity: 0.8,
        child: Card(
          color: Colors.white.withOpacity(0.10),
          elevation: 4,
          child: ListTile(
            title: Text(
              lahan.namaLahan,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewLahanDetail(lahan: lahan),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Color.fromARGB(255, 248, 248, 249),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Color.fromARGB(255, 248, 248, 249),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
