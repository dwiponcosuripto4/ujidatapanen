// widget/search_dialog.dart
import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final Function(String) onSearch;

  const SearchDialog({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search'),
      content: TextField(
        decoration: InputDecoration(
          labelText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: onSearch,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
