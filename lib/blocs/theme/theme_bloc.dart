import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/blocs/theme/theme_event.dart';
import 'package:travel_in/blocs/theme/theme_state.dart';
import 'package:travel_in/mocks/theme.dart';
import 'package:travel_in/resourse.dart';

class ThemeChangeBloc extends Bloc<ThemeChangeEvent, ThemeChangeState> {
  final resource = Resources();

  ThemeChangeBloc() : super(null);

  @override
  Stream<ThemeChangeState> mapEventToState(ThemeChangeEvent event) async* {
    if (event is GetThemeChangeEvent) {
      yield* _mapEventToStateGet();
    } else if (event is SetThemeChangeEvent) {
      yield* _mapEventToStateSet(event.theme);
    }
  }

  Stream<ThemeChangeState> _mapEventToStateGet() async* {
    AppTheme theme = await resource.getTheme();
    yield GetThemeState(theme);
  }

  Stream<ThemeChangeState> _mapEventToStateSet(String theme) async* {
    String getTheme = await resource.setTheme(theme);
    yield SetThemeState(getTheme);
  }
}