import 'dart:async';

import 'package:e_com/Screens/home_Screen.dart';
import 'package:e_com/Screens/onBoarding_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_Screen.dart';

class spleshScreen extends StatefulWidget {
  const spleshScreen({super.key});


  State<spleshScreen> createState() => _spleshScreenState();
}


class _spleshScreenState extends State<spleshScreen> {

  skipLoginScreen() async{
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    bool isLogin = sharedpref.getBool("ISLOGIN") ?? false;

    if(isLogin == false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const onBoarding(),));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const homeScreen(),));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(const Duration(seconds: 4), (timer) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => onBoarding(),));
      skipLoginScreen();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/ecom2.gif")
                )
              ),
            ),
          ),
          Text("TechNest",
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 30,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).highlightColor
            ),
          )
        ],
      ),
    );
  }
}
