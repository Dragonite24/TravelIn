import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel_in/models/sberservice.dart';
import 'package:travel_in/screen/embed.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return sberCard(context, index);
          }),
        ),
      ),
    );
  }

  Widget sberCard(BuildContext context, int i) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Color(0x85FFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: IconButton(
            iconSize: 100,
            icon: Image.asset(
              links[i].icon,
              fit: BoxFit.contain,
            ),
            onPressed: () {
              String url = links[i].url;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Embed(
                    url: url,
                    color: links[i].color,
                    title: links[i].title,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
