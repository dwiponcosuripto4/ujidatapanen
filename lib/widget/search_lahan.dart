import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onChanged;

  SearchDialog({required this.searchQuery, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),

      content: TextField(
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle: TextStyle(fontSize: 16),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
