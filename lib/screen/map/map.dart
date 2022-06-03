import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_in/blocs/attractions/attractions_bloc.dart';
import 'package:travel_in/blocs/attractions/attractions_state.dart';
import 'package:travel_in/components/indicator.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/models/attractions_model.dart';
import 'package:travel_in/screen/attractions/attraction_card.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Completer<GoogleMapController> _googleMapController = Completer();

  Set<Marker> _markers = {};
  int selectedNumber = 0;

  double latitude = 0.0, longitude = 0.0;

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> lines = {};

  double popupOpacity = 0;

  Future<Set<Marker>> getMarkers(List<Attraction> data, state) async {
    _markers = {};
    _markers.add(
      Marker(
        markerId: MarkerId('my_position'),
        position: LatLng(state.lat, state.lon),
        icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(67.5, 54),
          ),
          'assets/map/green_marker.png',
        ),
      ),
    );
    for (int i = 0; i < data.length; i++) {
      _markers.add(
        Marker(
          onTap: () {
            print("$i");
            popupOpacity = 1;
            setState(() {
              selectedNumber = i;
            });
          },
          markerId: MarkerId(i.toString()),
          position: LatLng(
            data[i].latitude,
            data[i].longitude,
          ),
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              size: Size(67.5, 54),
            ),
            'assets/map/marker.png',
          ),
          infoWindow: InfoWindow(
            title: "${data[i].name}",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AttractionCard(
                    attraction: state.attractions[i],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    // _changeCameraPosition(state);
    return _markers;
  }

  Future<void> _changeCameraPosition(state) async {
    try {
      final GoogleMapController controller = await _googleMapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              state.lat,
              state.lon,
            ),
            zoom: 13,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  List<Attraction> attractions;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AttractionsBloc, AttractionsState>(
      builder: (BuildContext context, AttractionsState state) {
        if (state is AttractionsLoadedState) {
          return Scaffold(
            body: FutureBuilder<Set<Marker>>(
              future: getMarkers(state.attractions, state),
              builder:
                  (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
                if (snapshot.data != null) {
                  return SafeArea(
                    child: Stack(
                      children: [
                        GoogleMap(
                          markers: snapshot.data,
                          zoomControlsEnabled: false,
                          polylines: Set<Polyline>.of(lines.values),
                          onTap: (value) => {popupOpacity = 0},
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              state.attractions.first.latitude,
                              state.attractions.first.longitude,
                            ),
                            zoom: 14.4746,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _googleMapController.complete(controller);
                          },
                        ),
                        Visibility(
                            visible: popupOpacity != 0 ? true : false,
                            child: popUp(state)),
                      ],
                    ),
                  );
                } else {
                  return Indicator.circle;
                }
              },
            ),
          );
        } else {
          return Indicator.circle;
        }
      },
    );
  }

  Widget popUp(state) {
    return AnimatedOpacity(
      opacity: popupOpacity,
      duration: Duration(milliseconds: 400),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: CColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: CColors.grey,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: CColors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    state.attractions[selectedNumber].name,
                                    style: TextStyle(
                                        color: CColors.dark_grey, fontSize: 18),
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                                Text(
                                  state.attractions[selectedNumber].latitude
                                      .toString(),
                                  style: TextStyle(
                                      color: CColors.grey, fontSize: 12),
                                ),
                                Text(
                                  state.attractions[selectedNumber].longitude
                                      .toString(),
                                  style: TextStyle(
                                      color: CColors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => {},
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Center(
                                child: Icon(
                                  Icons.directions_walk_rounded,
                                  color: CColors.dark_grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
