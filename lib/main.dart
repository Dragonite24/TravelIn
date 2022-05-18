import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/bloc/bloc_events/theme_event.dart';
import 'package:travel_in/bloc/theme_bloc.dart';
import 'package:travel_in/mocks/theme.dart';
import 'package:travel_in/screen/auth/auth.dart';
import 'bloc/bloc_states/theme_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeChangeBloc()..add(GetThemeChangeEvent()),
        )
      ],
      child: BlocBuilder<ThemeChangeBloc, ThemeChangeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Travel In',
            theme: (state is GetThemeState)
                ? appThemeData[state.theme]
                : appThemeData[AppTheme.BlueLight],
            home: AuthPage(),
          );
        },
      ),
    );
  }
}
