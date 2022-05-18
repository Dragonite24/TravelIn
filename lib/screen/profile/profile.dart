import 'package:flutter/material.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/models/sberservice.dart';
import 'package:travel_in/screen/embed.dart';
import 'package:travel_in/screen/profile/settings.dart';

class ProfilePage extends StatefulWidget {
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
  ];

  @override
  Widget build(BuildContext context) {
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
                        backgroundImage: AssetImage('assets/currentUser.jpg'),
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
                Container(
                  height: 50,
                  child: Column(
                    children: [
                      const Expanded(
                        child: Divider(color: CColors.grey),
                      ),
                      InkWell(
                        onTap: () => {},
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data[i],
                                style: const TextStyle(fontSize: 16),
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
                )
            ],
          ),
        ),
      ),
    );
  }
}
