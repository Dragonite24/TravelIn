import 'package:flutter/material.dart';
import 'package:travel_in/screen/map.dart';
import 'package:travel_in/screen/prear.dart';
import 'package:travel_in/screen/profile.dart';
import 'package:travel_in/screen/rating.dart';
import 'package:travel_in/screen/shop.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _seletedItem = 0;

  /// Страницы,
  var _pages = [
    /// todo: добавить потом другие страницы
    RatingPage(),
    ShopPage(),
    MapPage(),
    PreARPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_seletedItem],
      ),

      /// Нижняя навигационная панель
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFFFFB900),
          unselectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Colors.white),
          selectedLabelStyle: TextStyle(color: Colors.grey),
          selectedItemColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset('assets/favorites.png',
                    width: 30, height: 30, fit: BoxFit.contain),
                label: "Рейтинг"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/shopping-cart.png',
                    width: 30, height: 30, fit: BoxFit.contain),
                label: "Магазин"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/placeholder.png',
                    width: 30, height: 30, fit: BoxFit.contain),
                label: "Карта"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/bear.png',
                    width: 30, height: 30, fit: BoxFit.contain),
                label: "Гид"),
            BottomNavigationBarItem(
                icon: Image.asset('assets/user.png',
                    width: 30, height: 28, fit: BoxFit.contain),
                label: "Профиль"),
          ],
          currentIndex: _seletedItem,
          onTap: (index) {
            setState(
              () {
                _seletedItem = index;
              },
            );
          },
        ),
      ),
    );
  }
}
