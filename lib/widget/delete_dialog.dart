// widget/delete_dialog.dart
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String namaLoading;
  final VoidCallback onDelete;

  const DeleteDialog({
    Key? key,
    required this.namaLoading,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Loading'),
      content: Text(
        'Are you sure you want to delete $namaLoading?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.of(context).pop();
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
