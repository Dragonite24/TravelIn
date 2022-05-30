import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/blocs/auth/auth_bloc.dart';
import 'package:travel_in/blocs/auth/auth_event.dart';
import 'package:travel_in/blocs/auth/auth_state.dart';
import 'package:travel_in/components/indicator.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/screen/auth/auth.dart';
import 'package:travel_in/screen/profile/settings.dart';

class ProfilePage extends StatefulWidget {
  final AuthBloc authBloc;

  const ProfilePage({Key key, this.authBloc}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> data = [
    'Мои заметки',
    'Избранное',
    'История ',
    'Мои отзывы',
    'Уведомления',
    'Выход'
  ];

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = widget.authBloc;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, AuthState state) {
        print('state: ${state}');
        if (state is AuthInit) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Settings()),
                        ),
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              backgroundColor: CColors.dark_grey,
                              backgroundImage:
                                  AssetImage('assets/currentUser.jpg'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                FittedBox(
                                  child: Text(
                                    'Колесников Семен',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Text(
                                  'Мои данные',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    for (int i = 1; i < data.length; i++)
                      Panel(text: data[i],bloc: authBloc)
                  ],
                ),
              ),
            ),
          );
        } else {
          return Indicator.circle;
        }
      },
    );
  }
}

class Panel extends StatelessWidget {
  final AuthBloc bloc;
  final String text;

  const Panel({Key key, this.text, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        children: [
          const Expanded(
            child: Divider(color: CColors.grey),
          ),
          InkWell(
            onTap: () => {'Выход' == text ? bloc.add(LoggedOut()) : null},
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 16,
                        color: 'Выход' == text ? CColors.red : null),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
