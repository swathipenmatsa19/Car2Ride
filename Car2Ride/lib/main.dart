import 'package:flutter/material.dart';
import './view/frontpage.dart';

void main() => runApp(CarRideApp());

class CarRideApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FrontPage(),
    );
  }
  
}