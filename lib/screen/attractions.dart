import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_in/models/attractions_model.dart';

/// Экран с информацией о достопримечательости
class AttractionsScreen extends StatefulWidget {
  final Attraction attraction;

  AttractionsScreen({this.attraction});
  @override
  _AttractionsScreenState createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {
  Completer<GoogleMapController> _googleMapController = Completer();

  bool mapLoaded = false;
  BitmapDescriptor bitmapDescriptor;
  void loadMap() async {
    bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(67.5, 54),
      ),
      'assets/map/marker.png',
    );
    setState(() {
      mapLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadMap();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 200,
            flexibleSpace: Image.network(
              widget.attraction.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.attraction.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                for (String question in widget.attraction.questions.keys) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      question,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(widget.attraction.questions[question]),
                  ),
                ],
                Container(
                  height: 500,
                  child: mapLoaded
                      ? GoogleMap(
                          markers: {
                            Marker(
                              onTap: () {},
                              markerId: MarkerId(""),
                              position: LatLng(
                                widget.attraction.latitude,
                                widget.attraction.longitude,
                              ),
                              icon: bitmapDescriptor,
                            ),
                          },
                          onTap: (value) => setState(() {}),
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              widget.attraction.latitude,
                              widget.attraction.longitude,
                            ),
                            zoom: 14.4746,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _googleMapController.complete(controller);
                          },
                        )
                      : null,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
