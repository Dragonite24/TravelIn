import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_in/blocs/attractions/attractions_event.dart';
import 'package:travel_in/blocs/attractions/attractions_state.dart';
import 'package:travel_in/client.dart';
import 'package:travel_in/models/attractions_model.dart';
import 'package:travel_in/repositories/api_repository.dart';

class AttractionsBloc extends Bloc<AttractionsEvents, AttractionsState> {
  final AuthRepository api;
  final List country;
  double lat;
  double lon;

  AttractionsBloc({this.api, this.country, this.lat, this.lon})
      : super(AttractionsInitialState());

  /// Получает местоположение пользователя (lat, long)
  Future<List> getMyLocation() async {
    try {
      await client.determinePosition().then(
            (value) => {
              lat = value.latitude,
              lon = value.longitude,
            },
          );
      return await placemarkFromCoordinates(lat, lon);
    } catch (e) {
      print('getMyLocation $e');
    }
  }

  @override
  Stream<AttractionsState> mapEventToState(AttractionsEvents event) async* {
    switch (event) {
      case AttractionsEvents.fetchAttractions:
        yield AttractionsLoadingState();
        try {
          final AttractionModel data = await api.getAttractions();
          final List country = await getMyLocation();
          yield AttractionsLoadedState(
              attractions: data.attractions,
              country: country,
              lat: 57.622325,
              lon: 39.901884);
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
          if (DioErrorType.connectTimeout == e.type ||
              DioErrorType.receiveTimeout == e.type) {
            yield AttractionsErrorState(
              error: ('Нет интернета (timeout)'),
            );
          } else {
            yield AttractionsErrorState(
              error: ('Неизвестная ошибка ${e.toString()}'),
            );
          }
        }
        break;
      case AttractionsEvents.clearData:
        super.close();
        break;
    }
  }
}
