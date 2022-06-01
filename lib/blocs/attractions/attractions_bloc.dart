import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_in/blocs/attractions/attractions_event.dart';
import 'package:travel_in/blocs/attractions/attractions_state.dart';
import 'package:travel_in/client.dart';
import 'package:travel_in/models/attractions_model.dart';
import 'package:travel_in/repositories/api_repository.dart';

class AttractionsBloc extends Bloc<AttractionsEvents, AttractionsState> {
  final AuthRepository api;

  AttractionsBloc({this.api}) : super(AttractionsInitialState());

  // /// Получает местоположение пользователя (lat, long)
  // Future<Address> getMyLocation() async {
  //   try {
  //     GeoCode geoCode = GeoCode(apiKey: '583931619451374303620x58751');
  //     Future<Address> getCountryName() async {
  //       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //       final coordinates = Coordinates(latitude: position.latitude, longitude: position.longitude);
  //       print(geoCode.apiKey);
  //       Future<Address> addresses =  geoCode.reverseGeocoding(latitude: coordinates.latitude, longitude: coordinates.longitude);
  //
  //       return addresses;
  //     }
  //     return await getCountryName();
  //   } catch (e) {
  //     log('getMyLocation $e');
  //   }
  // }

  @override
  Stream<AttractionsState> mapEventToState(AttractionsEvents event) async* {
    print(event);
    switch (event) {
      case AttractionsEvents.fetchAttractions:
        yield AttractionsLoadingState();
        try {
          final AttractionModel data = await api.getAttractions();
          // final Address country = await getMyLocation();
          yield AttractionsLoadedState(attractions: data.attractions);
        } on SocketException {
          yield AttractionsErrorState(
            error: ('Нет интернета'),
          );
        } on HttpException {
          yield AttractionsErrorState(
            error: ('Данные временно недоступны'),
          );
        } on FormatException {
          yield AttractionsErrorState(
            error: ('FormatException'),
          );
        } catch (e) {
          print(e.toString());
          yield AttractionsErrorState(
            error: ('Неизвестная ошибка ${e.toString()}'),
          );
        }
        break;
    }
  }
}
