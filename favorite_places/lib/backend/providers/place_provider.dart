import 'dart:io';

import 'package:favorite_places/backend/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(p.join(dbPath, 'places.db'), version: 1,
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places (id TEXT PRIMARY KEY, name TEXT, image TEXT, lat REAL, lng REAL)');
  });

  return db;
}

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data.map((row) {
      return Place(
          id: row['id'] as String,
          name: row["name"] as String,
          image: File(row['image'] as String),
          placeLocation: PlaceLocation(
              latitude: row['lat'] as double, longitude: row['lng'] as double));
    }).toList();

    state = places;
  }

  void addNewPlace(Place newPlace) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();

    final imageName = p.basename(newPlace.image.path);
    final newPath = await newPlace.image.copy("${appDir.path}/$imageName");
    newPlace.image = newPath;

    final db = await _getDatabase();
    db.insert("user_places", {
      'id': newPlace.id,
      'name': newPlace.name,
      'image': newPlace.image.path,
      'lat': newPlace.placeLocation.latitude,
      'lng': newPlace.placeLocation.longitude,
    });
    state = [newPlace, ...state];
  }
}

final placeNotifier = StateNotifierProvider<PlaceNotifier, List<Place>>(
  (ref) {
    return PlaceNotifier();
  },
);
