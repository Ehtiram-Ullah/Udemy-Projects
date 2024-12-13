import 'dart:io';

import 'package:uuid/uuid.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;

  PlaceLocation({required this.latitude, required this.longitude});
}

class Place {
  final String name;

  File image;

  final PlaceLocation placeLocation;

  final String id;
  Place(
      {required this.name,
      String? id,
      required this.image,
      required this.placeLocation})
      : id = id ?? const Uuid().v4();
}
