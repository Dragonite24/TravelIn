import 'package:equatable/equatable.dart';
import 'package:geocode/geocode.dart';
import 'package:travel_in/models/attractions_model.dart';

abstract class AttractionsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AttractionsLoadingState extends AttractionsState {}

class AttractionsInitialState extends AttractionsState {}

class AttractionsLoadedState extends AttractionsState {
  final List<Attraction> attractions;
  // final Address country;

  AttractionsLoadedState({this.attractions});
}

class AttractionsErrorState extends AttractionsState {
  final error;

  AttractionsErrorState({this.error});
}
