import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_in/blocs/attractions/attractions_bloc.dart';
import 'package:travel_in/blocs/attractions/attractions_event.dart';
import 'package:travel_in/blocs/attractions/attractions_state.dart';
import 'package:travel_in/client.dart';
import 'package:travel_in/components/indicator.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/screen/attractions/attraction_card.dart';
import 'package:travel_in/screen/guide/prear.dart';

class AttractionsPage extends StatefulWidget {
  @override
  _AttractionsPageState createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  double latitude = 0.0, longitude = 0.0;

  /// Получает местоположение пользователя (lat, long)
  Future<bool> getMyLocation() async {
    try {
      await client.determinePosition().then(
            (value) => {
              latitude = 57.622325,
              longitude = 39.901884,
            },
          );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  double getDistance(double latMark, double longMark) {
    return parseDistance(
        Geolocator.distanceBetween(latitude, longitude, latMark, longMark));
  }

  double parseDistance(double data) {
    return double.parse((data / 1000).toStringAsFixed(3));
  }

  @override
  void initState() {
    loadAttractions();
    super.initState();
  }

  loadAttractions() async {
    if (!(context.read<AttractionsBloc>().state is AttractionsLoadedState)) {
      context.read<AttractionsBloc>().add(AttractionsEvents.fetchAttractions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttractionsBloc, AttractionsState>(
      builder: (BuildContext context, AttractionsState state) {
        print(state);
        if (state is AttractionsLoadedState) {
          String country =
              '${state.country[0].country}, ${state.country[0].locality}';
          return Scaffold(
            appBar: AppBar(
              title: Text(country.toString()),
            ),
            body: SafeArea(
              child: FutureBuilder<bool>(
                future: getMyLocation(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: ClipRRect(
                              child: ListView.builder(
                                itemCount: state.attractions.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return row(state, index);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Indicator.circle;
                  }
                },
              ),
            ),
          );
        } else if (state is AttractionsLoadingState) {
          return Indicator.circle;
        } else if (state is AttractionsErrorState) {
          return Scaffold(body: Center(child: Text(state.error)));
        } else {
          return Indicator.circle;
        }
      },
    );
  }

  Widget row(state, index) {
    double distance = getDistance(
        state.attractions[index].latitude, state.attractions[index].longitude);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AttractionCard(
            attraction: state.attractions[index],
          ),
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: distance > 1 ? CColors.white.withOpacity(0.1) : null),
        child: SizedBox(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: CColors.black,
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor: CColors.light_grey,
                      backgroundImage: NetworkImage(
                        state.attractions[index].imageUrl,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.attractions[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$distanceкм, до вас',
                          style: TextStyle(
                            color: CColors.grey,
                            fontSize: 12.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (state.attractions[index].rating != null)
                          Text(
                            'Рейтинг: ${state.attractions[index].rating.toStringAsPrecision(2)}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PreARPage(
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.person_pin_circle_outlined,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   const PI = math.pi;
//   const EARTH_RADIUS = 6372795;
//
//   /// перевеов координат в радианы
//   final lat1 = latitude * PI / 180;
//   final lat2 = latMark * PI / 180;
//   final long1 = longitude * PI / 180;
//   final long2 = longMark * PI / 180;
//
//   /// косинусы и синусы широт и разницы долгот
//   final cl1 = math.cos(lat1);
//   final cl2 = math.cos(lat2);
//   final sl1 = math.sin(lat1);
//   final sl2 = math.sin(lat2);
//
//   final delta = long2 - long1;
//   final cdelta = math.cos(delta);
//   final sdelta = math.sin(delta);
//
//   /// вычисления длины большого круга
//   final y = math.sqrt(math.pow(cl2 * sdelta, 2) +
//       math.pow(cl1 * sl2 - sl1 * cl2 * cdelta, 2));
//   final x = sl1 * sl2 + cl1 * cl2 * cdelta;
//
//   final ad = math.atan2(y, x);
//   final result = ad * EARTH_RADIUS;
//
//   return result;
// }
//
