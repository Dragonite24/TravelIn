import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_in/models/attractions_model.dart';

abstract class AttractionsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AttractionsLoadingState extends AttractionsState {}

class AttractionsInitialState extends AttractionsState {}

class AttractionsLoadedState extends AttractionsState {
  final List<Attraction> attractions;
  final List<Placemark> country;
  final lat;
  final lon;

  AttractionsLoadedState({this.attractions, this.country, this.lat, this.lon});
}

class AttractionsErrorState extends AttractionsState {
  final error;

  AttractionsErrorState({this.error});
}
