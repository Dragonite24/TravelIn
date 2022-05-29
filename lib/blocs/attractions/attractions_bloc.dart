import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/blocs/attractions/attractions_event.dart';
import 'package:travel_in/blocs/attractions/attractions_state.dart';
import 'package:travel_in/mocks/mocks.dart';
import 'package:travel_in/models/attractions_model.dart';
import 'package:travel_in/resourse.dart';

class AttractionsBloc extends Bloc<AttractionsChangeEvent, AttractionsChangeState> {
  final resource = Resources();

  AttractionsBloc() : super(null);

  @override
  Stream<AttractionsChangeState> mapEventToState(AttractionsChangeEvent event) async* {
    if (event is GetAttractionsChangeEvent) {
      yield* _mapEventToStateGet();
    }
  }

  Stream<AttractionsChangeState> _mapEventToStateGet() async* {
    List<Attraction> attractions = await mocks.getAttractions();
    yield GetAttractionsState(attractions);
  }

}