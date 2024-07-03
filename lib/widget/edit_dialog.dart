// widget/edit_dialog.dart
import 'package:flutter/material.dart';
import 'package:ujidatapanen/controller/EditLoadingController.dart';
import 'package:ujidatapanen/model/loading.dart';
import 'package:ujidatapanen/screen/map/map_screen.dart';

class EditDialog extends StatefulWidget {
  final Loading loading;
  final Function() onUpdate;

  const EditDialog({Key? key, required this.loading, required this.onUpdate})
      : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController namaLoadingController;
  late TextEditingController pemilikController;
  late TextEditingController alamatController;
  String? lokasi;

  final EditLoadingController _editLoadingController = EditLoadingController();

  @override
  void initState() {
    super.initState();
    namaLoadingController =
        TextEditingController(text: widget.loading.namaLoading);
    pemilikController = TextEditingController(text: widget.loading.pemilik);
    alamatController = TextEditingController(text: widget.loading.alamat);
    lokasi = widget.loading.lokasi;
  }

  @override
  void dispose() {
    namaLoadingController.dispose();
    pemilikController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Loading'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: namaLoadingController,
            decoration: const InputDecoration(labelText: 'Nama Loading'),
          ),
          TextFormField(
            controller: pemilikController,
            decoration: const InputDecoration(labelText: 'Pemilik'),
          ),
          TextFormField(
            controller: alamatController,
            decoration: const InputDecoration(labelText: 'Alamat'),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(lokasi ?? 'Lokasi belum dipilih'),
              ),
              IconButton(
                icon: Icon(Icons.map),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        onLocationSelected: (selectedLocation) {
                          setState(() {
                            lokasi = selectedLocation;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            String namaLoading = namaLoadingController.text;
            String pemilik = pemilikController.text;
            String alamat = alamatController.text;
            lokasi = lokasi ?? '';

            if (lokasi!.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Lokasi harus dipilih'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            Loading updatedLoading = Loading(
              id: widget.loading.id,
              namaLoading: namaLoading,
              pemilik: pemilik,
              alamat: alamat,
              lokasi: lokasi!,
              userId: widget.loading.userId,
            );

            bool updateSuccess = await _editLoadingController.updateLoading(
                context, updatedLoading);
            if (updateSuccess) {
              widget.onUpdate();
              Navigator.of(context).pop();
            }
          },
          child: Text('Simpan'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Batal'),
        ),
      ],
    );
  }
}
