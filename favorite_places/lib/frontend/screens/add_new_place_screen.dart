import 'dart:io';

import 'package:favorite_places/backend/models/place.dart';
import 'package:favorite_places/frontend/widgets/image_input.dart';
import 'package:favorite_places/frontend/widgets/location_input.dart';
import 'package:flutter/material.dart';

class AddNewPlaceScreen extends StatelessWidget {
  AddNewPlaceScreen({super.key});

  final TextEditingController _place = TextEditingController();

  File? pickedImage;

  PlaceLocation? _placeLocation;

  void addImage(File image) {
    pickedImage = image;
  }

  void addLocation(PlaceLocation location) {
    _placeLocation = location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _place,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: const InputDecoration(label: Text("Title")),
            ),
            const SizedBox(
              height: 20,
            ),
            ImageInput(
              onPickImage: addImage,
            ),
            const SizedBox(
              height: 20,
            ),
            LocationInput(
              onTap: addLocation,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_place.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill the field")));
                    return;
                  }
                  if (pickedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select an image")));
                    return;
                  }
                  if (_placeLocation == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select a location")));
                    return;
                  }
                  Navigator.pop(
                      context,
                      Place(
                          name: _place.text,
                          image: pickedImage!,
                          placeLocation: _placeLocation!));
                },
                label: const Text("Add Place"),
                icon: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
