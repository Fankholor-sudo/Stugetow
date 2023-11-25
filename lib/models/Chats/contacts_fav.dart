import 'package:flutter/material.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteStates.dart';
import 'package:stugetow/screens/Chats/UserProfileDestination.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';
import 'package:stugetow/views/separateClasses/Chats/messages.dart';

class ContactFavorite extends StatefulWidget {
  @override
  _ContactFavorite createState() => _ContactFavorite();
}

class _ContactFavorite extends State<ContactFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueGrey[600]),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text(
                  "Friends",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                    fontSize: 15.0,
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
                  onTap: () =>
                      Navigator.push(context,
                        AnimatedPageRouteStates(page: UserDestinationScreen(
                          destination: favs,
                        ),),
                      ),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    width: 75.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: favs.imageUrl,
                          child: CircleAvatar(
                            radius: 28.0,
                            backgroundImage: AssetImage(favs.imageUrl),
                          ),
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
