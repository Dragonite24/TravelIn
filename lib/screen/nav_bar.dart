import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_in/blocs/auth/auth_bloc.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/screen/map/map.dart';
import 'package:travel_in/screen/guide/prear.dart';
import 'package:travel_in/screen/profile/profile.dart';
import 'package:travel_in/screen/attractions/attractions.dart';

class Navbar extends StatefulWidget {
  final AuthBloc authBloc;

  const Navbar({Key key, this.authBloc}) : super(key: key);

  @override
  NavbarState createState() => NavbarState();
}

class NavbarState extends State<Navbar> {
  AuthBloc authBloc;
  List<Widget> items;

  @override
  void initState() {
    authBloc = widget.authBloc;
    items = [
      AttractionsPage(),
      MapPage(),
      // AttractionsPage(),
      PreARPage(),
      ProfilePage(authBloc: authBloc),
    ];
    super.initState();
  }

  final myKey = GlobalKey<NavbarState>();
  int _selectedItem = 0;

  final _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: CColors.white,
              boxShadow: [
                BoxShadow(
                  color: CColors.dark_grey,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              navButton(Icons.list_rounded, 'Список', 0),
              navButton(Icons.map_rounded, 'Карта', 1),
              navButton(Icons.person_search_rounded, 'Гид', 2),
              navButton(Icons.person, 'Профиль', 3),
            ],
          )),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),

        controller: _pageController,
        children: items,
      ),
    );
  }

  Widget navButton(IconData icon, String txt, int index) {
    return SizedBox(
      width: 80,
      height: 60,
      child: InkWell(
        onTap: () {
          _pageController.jumpToPage(index);
          _selectedItem = index;
          setState(() {});
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                icon,
                size: 30,
                color:
                    _selectedItem == index ? CColors.dark_grey : CColors.grey,
              ),
            ),
            txt.isNotEmpty
                ? FittedBox(
                    child: Text(
                      txt,
                      style: TextStyle(
                          color: _selectedItem == index
                              ? CColors.dark_grey
                              : CColors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 11),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
