import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Positioned(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
      ),
      child: Center(
        child:CircularProgressIndicator(),
      ),
    ),
  );

}