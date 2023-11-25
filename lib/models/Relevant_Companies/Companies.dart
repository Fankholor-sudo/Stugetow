import 'package:flutter/material.dart';
import 'package:stugetow/models/Relevant_Companies/RelevantPageEdit.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';

class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Relevant Company",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                    fontSize: 18.0,
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(context,AnimatedPageRouteSlide(
                      page: RelevantEdit()
                    ));
                  },
                  child: Text(
                    "Edit...",
                    style: TextStyle(
                      color: Color.fromRGBO(41, 127, 212, 1),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.8,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
