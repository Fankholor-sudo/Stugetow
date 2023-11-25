import 'package:flutter/material.dart';
import 'package:stugetow/models/Institutions/PopupMenu/viewUsers.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRoute.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteStates.dart';
import 'package:stugetow/screens/Chats/UserProfileDestination.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';
import 'package:stugetow/views/separateClasses/Chats/messages.dart';

class StudentsFavorite extends StatefulWidget {
  @override
  _StudentsFavorite createState() => _StudentsFavorite();
}

class _StudentsFavorite extends State<StudentsFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(10, 90, 150, .7)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Students",
                  style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                  ),
                ),
                FlatButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      AnimatedPageRouteSlide(
                        page: ViewUsers(),
                      ),
                    ),
                  },
                  child: Text(
                    "See More...",
                    style: TextStyle(
                      color: Colors.white54.withOpacity(.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 5.0),
              scrollDirection: Axis.horizontal,
              itemCount: favorite.length,
              itemBuilder: (BuildContext context, int index) {
                final User favs = favorite[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    AnimatedPageRoute(
                      page: UserDestinationScreen(
                        destination: favs,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    width: 75.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            radius: 28.0,
                            backgroundImage: AssetImage(favs.imageUrl),
                          ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              favs.name,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: "cursive-monospace",
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
