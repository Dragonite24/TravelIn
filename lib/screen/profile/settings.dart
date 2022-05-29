import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/blocs/theme/theme_bloc.dart';
import 'package:travel_in/blocs/theme/theme_event.dart';
import 'package:travel_in/blocs/theme/theme_state.dart';


class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Настройки',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: BlocBuilder<ThemeChangeBloc, ThemeChangeState>(
        builder: (context, state) {
          String _groupValue = 'red';
          if (state is GetThemeState) {
            print(state.theme);
            _groupValue = state.theme.toString();
          }
          return SafeArea(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Выбор темы приложения:',
                      style: TextStyle(fontSize: 16),
                    ),
                    RadioListTile(
                      value: 'AppTheme.GreenLight',
                      groupValue: _groupValue,
                      title: Text("Светлая тема (зеленый)"),
                      onChanged: (newValue) {
                        print(newValue);
                        BlocProvider.of<ThemeChangeBloc>(context)
                            .add(SetThemeChangeEvent('GreenLight'));
                        BlocProvider.of<ThemeChangeBloc>(context)
                            .add(GetThemeChangeEvent());
                      },
                      activeColor: Colors.green,
                      selected: false,
                    ),
                    RadioListTile(
                      value: 'AppTheme.GreenDark',
                      groupValue: _groupValue,
                      title: Text("Темная тема (зеленый)"),
                      onChanged: (newValue) {
                        print(newValue);
                        BlocProvider.of<ThemeChangeBloc>(context)
                            .add(SetThemeChangeEvent('GreenDark'));
                        BlocProvider.of<ThemeChangeBloc>(context)
                            .add(GetThemeChangeEvent());
                      },
                      activeColor: Colors.green[700],
                      selected: false,
                    ),
                    RadioListTile(
                      value: 'AppTheme.BlueLight',
                      groupValue: _groupValue,
                      title: Text("Светлая тема (синий)"),
                      onChanged: (newValue) {
                        BlocProvider.of<ThemeChangeBloc>(context)
                            .add(SetThemeChangeEvent('BlueLight'));
                        BlocProvider.of<ThemeChangeBloc>(context)
                            .add(GetThemeChangeEvent());
                      },
                      activeColor: Colors.blue,
                      selected: false,
                    ),
                    RadioListTile(
                      value: 'AppTheme.BlueDark',
                      groupValue: _groupValue,
                      title: Text("Темная тема (синий)"),
                      onChanged: (newValue) {
                        BlocProvider.of<ThemeChangeBloc>(context)
                            .add(SetThemeChangeEvent('BlueDark'));
                        BlocProvider.of<ThemeChangeBloc>(context)
                            .add(GetThemeChangeEvent());
                      },
                      activeColor: Colors.blue[700],
                      selected: false,
                    ),
                    Text('Выбор темы приложения:', style: TextStyle(fontSize: 16),),
                  ],
                )),
          );
        },
      ),
    );
  }
}
