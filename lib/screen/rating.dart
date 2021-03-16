import 'package:flutter/material.dart';
import 'package:travel_in/client.dart';
import 'package:travel_in/screen/attractions.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    var attractions = client.getAttractions();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/4.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: ListView.builder(
            itemCount: client.getAttractions().length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AttractionsScreen(
                      attraction: attractions[index],
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(attractions[index].imageUrl),
                        ),
                      ),
                      Container(
                        width: 220,
                        height: 75,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0x85FFFFFF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              attractions[index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!client.getAttractions()[index].rating.isNaN)
                              Text(
                                'Рейтинг: ${attractions[index].rating.toStringAsPrecision(2)}',
                              ),
                          ],
                        ),
                      ),
                    ],
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
