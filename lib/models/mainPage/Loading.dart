import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: SpinKitCubeGrid(
          color: Color.fromRGBO(48, 126, 171,1),
          duration: Duration(milliseconds: 900),
          size:50,
        ),
      ),
    );
  }
}

