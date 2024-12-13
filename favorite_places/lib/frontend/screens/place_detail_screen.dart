import 'package:favorite_places/backend/models/place.dart';
import 'package:favorite_places/frontend/screens/show_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: FlutterMap(
                    options: MapOptions(
                      onTap: (_, __) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ShowMapScreen(
                                  isViewing: true,
                                  placeLocation: LatLng(
                                      place.placeLocation.latitude,
                                      place.placeLocation.longitude),
                                )));
                      },
                      initialCenter: LatLng(
                          place.placeLocation.latitude,
                          place.placeLocation
                              .longitude), // Center the map over London
                      initialZoom: 15,
                    ),
                    children: [
                      TileLayer(
                        // Display map tiles from any source
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                        userAgentPackageName: 'com.example.app',
                        subdomains: const ['a', 'b', 'c'],
                        // And many more recommended properties!
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            child: const Icon(Icons.location_pin,
                                color: Colors.red, size: 30),
                            point: LatLng(place.placeLocation.latitude,
                                place.placeLocation.longitude),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
