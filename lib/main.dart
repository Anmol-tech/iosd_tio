import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iosd_tio/Pages/HomePage.dart';
import 'package:iosd_tio/Pages/Posts.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(
              data: data,
            ),
      },
      initialRoute: '/',
      theme: ThemeData(
        accentColor: Colors.red[300],
        primaryColor: Colors.redAccent[400],
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
