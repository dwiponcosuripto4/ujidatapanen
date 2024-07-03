import 'package:flutter/material.dart';
import 'package:ujidatapanen/model/loading.dart';

class LoadingDropdown extends StatelessWidget {
  final int selectedLoadingId;
  final List<Loading> loadingList;
  final Function(int?) onChanged;

  const LoadingDropdown({
    required this.selectedLoadingId,
    required this.loadingList,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Pilih Loading',
        labelStyle: TextStyle(color: Colors.white),
      ),
      value: selectedLoadingId,
      items: loadingList.map((loading) {
        return DropdownMenuItem<int>(
          value: loading.id,
          child: Text(loading.namaLoading),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value == 0) {
          return 'Pilih Loading';
        }
        return null;
      },
    );
  }
}
