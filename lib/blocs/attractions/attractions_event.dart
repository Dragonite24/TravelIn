import 'package:equatable/equatable.dart';
import 'package:travel_in/models/attractions_model.dart';

abstract class AttractionsChangeEvent extends Equatable {
  const AttractionsChangeEvent();
}

class GetAttractionsChangeEvent extends AttractionsChangeEvent {
  @override
  List<Object> get props => [];
}

class SetAttractionsChangeEvent extends AttractionsChangeEvent {
  final List<Attraction> attractions;

  SetAttractionsChangeEvent(this.attractions);

  @override
  List<Object> get props => [attractions];
}