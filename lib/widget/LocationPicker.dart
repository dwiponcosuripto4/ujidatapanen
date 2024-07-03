// location_picker.dart
import 'package:flutter/material.dart';
import 'package:ujidatapanen/screen/map/map_screen.dart';

class LocationPicker extends StatefulWidget {
  final ValueChanged<String> onLocationSelected;
  final String? selectedLocation;

  const LocationPicker({
    Key? key,
    required this.onLocationSelected,
    this.selectedLocation,
  }) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.selectedLocation ?? 'Lokasi belum dipilih',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.map, color: Colors.white),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(
                  onLocationSelected: (selectedLocation) {
                    widget.onLocationSelected(selectedLocation);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
