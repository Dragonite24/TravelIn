import 'package:equatable/equatable.dart';
import 'package:travel_in/models/attractions_model.dart';

abstract class AttractionsChangeState extends Equatable {
  const AttractionsChangeState();
}

class GetAttractionsState extends AttractionsChangeState {
  final List<Attraction> attractions;

  GetAttractionsState(this.attractions);

  @override
  List<Object> get props => [attractions];
}

class SetAttractionsState extends AttractionsChangeState {
  final List<Attraction> attractions;

  SetAttractionsState(this.attractions);

  @override
  List<Object> get props => [attractions];
}