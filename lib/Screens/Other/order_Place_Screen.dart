import 'dart:async';

import 'package:e_com/Screens/home_Screen.dart';
import 'package:flutter/material.dart';

class OrderPlaceScreen extends StatefulWidget {
  const OrderPlaceScreen({super.key});

  @override
  State<OrderPlaceScreen> createState() => _OrderPlaceScreenState();
}


class _OrderPlaceScreenState extends State<OrderPlaceScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homeScreen(),), (route) => false,);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Image(
            image: AssetImage("assets/successfully.png"),fit: BoxFit.fill,
        ),
      ),
    );
  }
}
