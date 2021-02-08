import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lifestack/app/home/bricks_of_success/bricks_wall_page.dart';

class WallStats extends StatefulWidget {
  @override
  _WallStatsState createState() => _WallStatsState();
}

class _WallStatsState extends State<WallStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildStats(context),
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
      return Column(children: <Widget>[
      SizedBox(height: 20),
      Text('Day'),
        Row(children: <Widget>[Container(
          width: 100,
          height: 100,
          child: bricksWall(context)),
      ]),
      SizedBox(height: 20),
      Text('Week'),
      Row(children: <Widget>[Container(
          width: 100,
          height: 100,
          child: bricksWall(context)),
        Container(
          width: 100,
          height: 100,
          child: bricksWall(context)),
        Container(
          width: 100,
          height: 100,
          child: bricksWall(context))  
      ]),
      SizedBox(height: 20),
      Text('Month'),
      Row(children: <Widget>[Container(
          width: 100,
          height: 100,
          child: bricksWall(context)),
        Container(
          width: 100,
          height: 100,
          child: bricksWall(context)),
        Container(
          width: 100,
          height: 100,
          child: bricksWall(context))  
      ])
      
      ],
        
      );
    }
}