import 'package:favorite_places/backend/models/place.dart';
import 'package:favorite_places/frontend/screens/show_map_screen.dart';
import 'package:favorite_places/utils/get_address_from_coordinates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onTap,
  });

  final Function(PlaceLocation location) onTap;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _pickedLocation;
  bool isGettingLocation = false;

  Future<void> _getCurrentLocation() async {
    setState(() {
      isGettingLocation = true;
    });
    Location location = Location();
    LocationData locationData;

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Uh ohh.. Error while getting location.")));

      return;
    }
    setState(() {
      isGettingLocation = false;
    });
    _pickedLocation = locationData;
    widget.onTap(PlaceLocation(
        latitude: locationData.latitude!, longitude: locationData.longitude!));
    getAddressFromLatLng(locationData.latitude!, locationData.longitude!);
  }

  LatLng? _selectedLocation;
  Future<void> pickLocation(LatLng? pickedLocation) async {
    print(pickedLocation);
    if (pickedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select a location to continue.")));
      return;
    }
    setState(() {
      _selectedLocation = pickedLocation;
    });
    widget.onTap(PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2))),
          child: isGettingLocation
              ? const CircularProgressIndicator()
              : _selectedLocation != null
                  ? FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(
                          _selectedLocation!.latitude,
                          _selectedLocation!.longitude,
                        ), // Center the map over London
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
                              point: LatLng(_selectedLocation!.latitude,
                                  _selectedLocation!.longitude),
                            ),
                          ],
                        ),
                      ],
                    )
                  : _pickedLocation != null
                      ? FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                                _pickedLocation!.latitude!,
                                _pickedLocation!
                                    .longitude!), // Center the map over London
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
                                  point: LatLng(_pickedLocation!.latitude!,
                                      _pickedLocation!.longitude!),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Text(
                          "No location is chosen",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text("Get Current Location")),
            TextButton.icon(
                onPressed: () async {
                  final LatLng? selectedLocation =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShowMapScreen(
                      placeLocation: _selectedLocation,
                    ),
                  ));
                  pickLocation(selectedLocation);
                },
                icon: const Icon(Icons.map),
                label: const Text("Select on Map")),
          ],
        )
      ],
    );
  }
}
