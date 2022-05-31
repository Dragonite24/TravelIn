import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_in/blocs/attractions/attractions_bloc.dart';
import 'package:travel_in/blocs/attractions/attractions_state.dart';
import 'package:travel_in/client.dart';
import 'package:travel_in/components/indicator.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/mocks/mocks.dart';
import 'package:travel_in/models/attractions_model.dart';
import 'package:travel_in/screen/attractions/attraction_card.dart';

class AttractionsPage extends StatefulWidget {
  @override
  _AttractionsPageState createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage> {
  double latitude = 0.0, longitude = 0.0;
  List<Attraction> attractions = mocks.getAttractions();

  /// Получает местоположение пользователя (lat, long)
  Future<bool> getMyLocation() async {
    try {
      await client.determinePosition().then(
            (value) => {
              latitude = value.latitude,
              longitude = value.longitude,
            },
          );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  String getDistance(double latMark, double longMark) {
    return parseDistance(
        Geolocator.distanceBetween(latitude, longitude, latMark, longMark));
  }

  String parseDistance(double data) {
    return '${(data / 1000).toStringAsFixed(3)} км';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AttractionsBloc, AttractionsChangeState>(
        builder: (BuildContext context, AttractionsChangeState state) {
          if (state is GetAttractionsState) {
            return FutureBuilder<bool>(
              future: getMyLocation(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    child: ClipRRect(
                      child: ListView.builder(
                        itemCount: attractions.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AttractionCard(
                                  attraction: attractions[index],
                                ),
                              ),
                            ),
                            child: SizedBox(
                              height: 90,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: CColors.grey,
//backgroundImage: NetworkImage(attractionData[index].imageUrl),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    attractions[index].name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: CColors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${getDistance(attractions[index].latitude, attractions[index].longitude)}, до вас',
                                              style: TextStyle(
                                                color: CColors.grey,
                                                fontSize: 12.0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (!attractions[index]
                                                .rating
                                                .isNaN)
                                              Text(
                                                'Рейтинг: ${attractions[index].rating.toStringAsPrecision(2)}',
                                                style: TextStyle(
                                                  color: CColors.dark_grey,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Indicator.circle;
                }
              },
            );
          } else {
            return Indicator.circle;
          }
        },
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
