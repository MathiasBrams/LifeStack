import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class Achievements extends StatefulWidget {
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    
    return Container(
      height: 1000,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              _buildStats(context),],)
           ));
          }
    Widget _buildStats(BuildContext context) {
      return Column(
        children: <Widget>[
          medalsCard('Consistency'),
          medalsCard('Effort'),
          medalsCard('Specialization'),
          medalsCard('Jack of All Trades'),
        ],
      );
    }

    Padding medalsCard(String category) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Text(category, style: GoogleFonts.poppins(color: Colors.teal, textStyle: TextStyle(fontSize: 24))),
              SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Opacity(opacity: 1, child: Icon(FlutterIcons.medal_ent, color: Colors.orangeAccent)),
              Opacity(opacity: 0.2, child: Icon(FlutterIcons.medal_faw5s, color: Colors.grey)),
              Opacity(opacity: 0.2, child: Icon(FlutterIcons.medal_mco, color: Colors.grey)),
              Opacity(opacity: 0.2, child: Icon(FlutterIcons.trophy_award_mco, color: Colors.yellow)),
              Opacity(opacity: 0.2, child: Icon(FlutterIcons.trophy_ent, color: Colors.yellow))
            ],),
            SizedBox(height: 8),
            ],),
          )),
        );
    }
}