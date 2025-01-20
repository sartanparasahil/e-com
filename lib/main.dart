import 'package:e_com/Screens/splesh_Screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          highlightColor: Colors.black,
          disabledColor: Colors.grey.shade700,
          canvasColor: Colors.grey.shade100,
          cardColor: Colors.grey.shade100,
          hintColor: Colors.grey.shade400
    ),

    // Dark Theme
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade900,
        highlightColor: Colors.white,
        disabledColor: Colors.white70,
        canvasColor: Colors.black38,
        cardColor: Colors.grey.shade800,
        hintColor: Colors.grey.shade400
    ),
      home: const spleshScreen()
    );
  }
}
