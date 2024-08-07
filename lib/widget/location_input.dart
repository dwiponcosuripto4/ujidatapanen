import 'package:flutter/material.dart';
import 'package:ujidatapanen/screen/map/map_screen.dart';

class LocationInput extends StatelessWidget {
  final String? lokasi;
  final Function(String) onLocationSelected;

  const LocationInput({
    Key? key,
    required this.lokasi,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        IconButton(
          icon: const Icon(Icons.map, color: Colors.white),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(
                  onLocationSelected: onLocationSelected,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
