import 'package:flutter/material.dart';
import 'package:ujidatapanen/model/panen.dart';

class PanenList extends StatelessWidget {
  final List<Panen> panenList;

  const PanenList({Key? key, required this.panenList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: panenList.length,
      itemBuilder: (context, index) {
        var panen = panenList[index];
        return Card(
          child: ListTile(
            title: Text(panen.noPanen),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jumlah: ${panen.jumlah} Kg'),
                Text('Harga: ${panen.harga}'),
                Text('Tanggal Panen: ${panen.tanggalPanen.toIso8601String()}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
