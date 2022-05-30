import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/blocs/auth/auth_bloc.dart';
import 'package:travel_in/blocs/auth/auth_state.dart';
import 'package:travel_in/components/button.dart';
import 'package:travel_in/components/indicator.dart';
import 'package:travel_in/components/textfield.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/repositories/api_repository.dart';
import 'package:travel_in/screen/nav_bar.dart';

import '../../blocs/auth/auth_event.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc authBloc;
  final AuthRepository authRepository;

  const AuthPage({Key key, this.authRepository, this.authBloc})
      : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthBloc get _authBloc => widget.authBloc;

  void _login() {
    widget.authBloc.add(LoginProcess(
      email: _usernameController.text,
      password: _usernameController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: widget.authBloc,
      builder: (context, AuthState state) {
        print('AUTH_PAGE_STATE: ${state}');
        if (state is AuthInit) {
          widget.authBloc.add(AuthCheck());
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AuthHasToken || state is AuthData) {
          return Navbar(authBloc: widget.authBloc);
        }
        if (state is AuthFailed || state is LoginFailed) {
          return Scaffold(
            body: SafeArea(
              child: Container(
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
                            style: TextStyle(
                                fontSize: 48, fontWeight: FontWeight.bold)),
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
                        MyTextField(
                            text: 'Логин/Почта',
                            controller: _usernameController),
                        MyTextField(
                            text: 'Пароль', controller: _passwordController),
                        const SizedBox(height: 20),
                        MyButton(text: 'Войти', onTap: () => {_login()}),
                        TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Находится в разработке'),
                                backgroundColor: Colors.red,
                              ));
                            },
                            child: const Text(
                              'регистрация',
                              style: TextStyle(
                                  color: CColors.grey,
                                  decoration: TextDecoration.underline),
                            )),
                        (state is LoginFailed) ? Text(state.error) : Text(""),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        if (state is AuthLoading) {
          print('AuthLoading');
          return Scaffold(body: Indicator.circle);
        }
        if (state is LoginSuccess) {
          print('LoginSuccess');
          return Scaffold(body: Indicator.circle);
        }
        return Indicator.circle;
      },
    );
  }
}
