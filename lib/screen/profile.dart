import 'package:flutter/material.dart';
import 'package:travel_in/models/sberservice.dart';
import 'package:travel_in/screen/embed.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            /// Background IMG #2
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrounds/2.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 63,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  /// Иконки настроек и поиска
                  Container(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                /////////////////
                              },
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 50,
                          height: 50,
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                /////////////////
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  /// Пользователь и сервисы
                  Container(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Пользователь
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/currentUser.jpg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Колесников Семен',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text('Турист', style: TextStyle(color: Colors.black)),
                        Text(
                          'Ярославль',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                              fontSize: 10),
                        ),

                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Text('Последние используемые сервисы'),
                        ),

                        /// СБЕР Сервисы
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  /// Сбер аптека
                                  sberCard(context, 0),

                                  /// Сбер еда
                                  sberCard(context, 1),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  /// Сбер мобаил
                                  sberCard(context, 2),

                                  /// Ситимобил
                                  sberCard(context, 5),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sberCard(BuildContext context, int id) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: Color(0x85FFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Color(0x62F57600), blurRadius: 10.0, offset: Offset(0, 3))
        ],
      ),
      child: Center(
        child: IconButton(
          iconSize: 100,
          icon: Image.asset(
            links[id].icon,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Embed(
                  url: links[id].url,
                  title: links[id].title,
                  color: links[id].color,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
