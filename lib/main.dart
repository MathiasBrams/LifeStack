import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lifestack/app/landing_page.dart';
import 'package:lifestack/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.blueGrey[900]
        ),
        home: LandingPage(),
      ),
    );
  }
}




