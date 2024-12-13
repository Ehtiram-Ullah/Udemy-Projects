import 'package:favorite_places/backend/models/place.dart';
import 'package:favorite_places/backend/providers/place_provider.dart';
import 'package:favorite_places/frontend/screens/add_new_place_screen.dart';
import 'package:favorite_places/frontend/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    await ref.read(placeNotifier.notifier).loadPlaces();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final placeState = ref.watch(placeNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Places",
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final Place? newPlace = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewPlaceScreen(),
                    ));
                if (newPlace != null) {
                  ref.read(placeNotifier.notifier).addNewPlace(newPlace);
                }
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : placeState.isEmpty
              ? const Center(
                  child: Text(
                    "No places added yet.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final place = placeState[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundImage: FileImage(place.image),
                          // child: Image.file(place.image),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlaceDetailScreen(place: place),
                              ));
                        },
                        title: Text(place.name),
                      );
                    },
                    itemCount: placeState.length,
                  ),
                ),
    );
  }
}
