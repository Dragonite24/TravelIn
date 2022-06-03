import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/models/attractions_model.dart';

/// Экран с информацией о достопримечательости
class AttractionCard extends StatefulWidget {
  final Attraction attraction;

  AttractionCard({this.attraction});

  @override
  _AttractionCardState createState() => _AttractionCardState();
}

class _AttractionCardState extends State<AttractionCard> {
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                for (Question question in widget.attraction.questions) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      question.question,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      question.answer,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                Container(
                  height: 300,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Отзывы: ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      for (String feedback in widget.attraction.feedback) ...[
                        feedbackCard(feedback)
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget feedbackCard(text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: CColors.light_grey,
            backgroundImage: AssetImage('assets/user.png'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(text),
              ),
            ),
          )
        ],
      ),
    );
  }
}
