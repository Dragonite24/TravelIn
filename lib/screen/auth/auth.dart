import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/bloc/bloc_events/theme_event.dart';
import 'package:travel_in/bloc/bloc_states/theme_state.dart';
import 'package:travel_in/bloc/theme_bloc.dart';
import 'package:travel_in/components/button.dart';
import 'package:travel_in/components/textfield.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/screen/nav_bar.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController first = TextEditingController();
    TextEditingController second = TextEditingController();
    return BlocBuilder<ThemeChangeBloc, ThemeChangeState>(builder: (context, state) {
      return
      Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Travel IN',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  const FittedBox(
                    child: Text('Добро пожаловать!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  const Text('Войдите, чтобы продолжить',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 40),
                  MyTextField(text: 'Логин/Почта', controller: first),
                  MyTextField(text: 'Пароль', controller: second),
                  const SizedBox(height: 20),
                  MyButton(
                      text: 'Войти',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Navbar()));
                      }),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'регистрация',
                        style: TextStyle(
                            color: CColors.grey,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
