import 'package:flutter/material.dart';
import 'package:travel_in/client.dart';
import 'package:travel_in/constants.dart';
import 'package:travel_in/mocks/mocks.dart';
import 'package:travel_in/screen/attractions/attraction_card.dart';

class AttractionsPage extends StatefulWidget {
  @override
  _AttractionsPageState createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage> {
  @override
  Widget build(BuildContext context) {
    final attractions = mocks.getAttractions();
    return Scaffold(
      body: SizedBox(
        child: ClipRRect(
          child: ListView.builder(
            itemCount: mocks.getAttractions().length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AttractionCard(
                      attraction: attractions[index],
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: CColors.grey,
                            //backgroundImage: NetworkImage(attractions[index].imageUrl),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        attractions[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: CColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${0.6}км, до вас',
                                  style: TextStyle(
                                    color: CColors.grey,
                                    fontSize: 12.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (!mocks.getAttractions()[index].rating.isNaN)
                                  Text(
                                    'Рейтинг: ${attractions[index].rating.toStringAsPrecision(2)}',
                                    style: TextStyle(
                                      color: CColors.dark_grey,
                                      fontSize: 14.0,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
