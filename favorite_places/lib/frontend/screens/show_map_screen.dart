import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ShowMapScreen extends StatefulWidget {
  const ShowMapScreen({
    super.key,
    this.placeLocation,
    this.isViewing = false,
  });

  final LatLng? placeLocation;
  final bool isViewing;
  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  final MapController _mapController = MapController();
  LatLng? _selectedLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedLocation = widget.placeLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isViewing ? "Place Location" : "Pick Location"),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedLocation ??
                  const LatLng(41.40338, 2.17403), // Initial map center
              initialZoom: 15,
              onTap: widget.isViewing
                  ? null
                  : (tapPosition, point) {
                      setState(() {
                        _selectedLocation = point;
                      });
                    },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              /*
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
              */
              if (_selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 30,
                      ),
                      point: _selectedLocation!,
                    ),
                  ],
                ),
            ],
          ),
          if (_selectedLocation != null && !widget.isViewing)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _selectedLocation);
                },
                child: const Text('Confirm Location'),
              ),
            ),
        ],
      ),
    );
  }
}
