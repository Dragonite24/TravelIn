import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/blocs/attractions/attractions_bloc.dart';
import 'package:travel_in/blocs/attractions/attractions_event.dart';
import 'package:travel_in/blocs/auth/auth_bloc.dart';
import 'package:travel_in/blocs/theme/theme_bloc.dart';
import 'package:travel_in/blocs/theme/theme_event.dart';
import 'package:travel_in/blocs/theme/theme_state.dart';
import 'package:travel_in/mocks/theme.dart';
import 'package:travel_in/repositories/api_repository.dart';
import 'package:travel_in/screen/auth/auth.dart';

void main() {
  runApp(MyApp());
}

final AuthRepository authRepository = AuthRepository();

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider(
          create: (context) => ThemeChangeBloc()..add(GetThemeChangeEvent()),
        ),
        BlocProvider(
          create: (context) => AttractionsBloc(
            api: AuthRepository(),
          ),child: AuthPage(),
        )
      ],
      child: BlocBuilder<ThemeChangeBloc, ThemeChangeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Travel In',
            theme: (themeState is GetThemeState)
                ? appThemeData[themeState.theme]
                : appThemeData[AppTheme.BlueLight],
            home: AuthPage(
              authRepository: authRepository,
              authBloc: AuthBloc(authRepository: authRepository),
            ),
          );
        },
      ),
    );
  }
}
