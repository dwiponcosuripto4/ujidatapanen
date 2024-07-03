import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatelessWidget {
  final Function(ImageSource) onImageSourceSelected;
  final File? imageFile;

  const ImagePickerButton({
    required this.onImageSourceSelected,
    this.imageFile,
    Key? key,
  }) : super(key: key);

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  onImageSourceSelected(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  onImageSourceSelected(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _showImageSourceActionSheet(context),
          child: Text('Pilih Foto'),
        ),
        if (imageFile != null) Image.file(imageFile!),
      ],
    );
  }
}
