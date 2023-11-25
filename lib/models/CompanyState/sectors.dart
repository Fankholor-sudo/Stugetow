import 'package:flutter/material.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteStates.dart';
import 'package:stugetow/screens/CompanyState/StateDestinations.dart';
import 'package:stugetow/views/separateClasses/Company/jobsFeeds.dart';
import 'package:stugetow/views/separateClasses/Company/UserCompany.dart';

class Sector extends StatefulWidget {
  @override
  _SectorState createState() => _SectorState();
}

class _SectorState extends State<Sector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Company State",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 205.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 5.0),
              scrollDirection: Axis.horizontal,
              itemCount: favoriteJobFeeds.length,
              itemBuilder: (BuildContext context, int index) {
                final UserCompany _favs = favoriteJobFeeds[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context,
                    AnimatedPageRouteStates(page: StateDestinationScreen(
                        destination: _favs,
                    ),),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Hero(
                              tag: _favs.imageUrl,
                              child: Container(
                                height: 180.0,
                                width: 180.0,
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white54,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(_favs.imageUrl),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 2.0,
                              bottom: 3.0,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(27),
                                    bottomRight: Radius.circular(27),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 176.0,
                                      padding: EdgeInsets.only(left:7.0),
                                      child: Text(
                                        _favs.name,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.2,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                    Container(
                                      width: 176.0,
                                      padding: EdgeInsets.only(left:7.0),
                                      child: Text(
                                        _favs.faculty,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(255, 255, 255, .9)
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
