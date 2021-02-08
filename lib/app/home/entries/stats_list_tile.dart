import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_icon_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:lifestack/app/home/models/entry.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:lifestack/app/home/entries/entries_list_tile.dart';


class StatsListTile extends StatelessWidget {
  StatsListTile({this.entry});
  final Entry entry;

  Widget brickPicker(Entry entry) {
    if (entry == null) {
        return Image.asset('images/brick_template.png');
      } else if (entry.category == null) {
        return Image.asset('images/brick_template.png');
      } else if (entry.category == 'Mind') {
        return Image.asset('images/brick_L_purple.png');
      } else if (entry.category == 'Skills') {
        return Image.asset('images/brick_L_blue.png');
      } else if (entry.category == 'Abstain') {
        return Image.asset('images/brick_L.png');
      } else if (entry.category == 'Sports') {
        return Image.asset('images/brick_L_green.png');
      } else if (entry.category == 'Hustle') {
         return Image.asset('images/brick_L_black.png');
      } else if (entry.category == 'Romance') {
         return Image.asset('images/brick_L_pink.png');
      } else if (entry.category == 'Clean') {
         return Image.asset('images/brick_L_teal.png');
      } else if (entry.category == 'Career') {
         return Image.asset('images/brick_L_cyan.png');
      } else if (entry.category == 'Diet') {
         return Image.asset('images/brick_L_yellowAccent.png');
      } else if (entry.category == 'Finances') {
         return Image.asset('images/brick_L_lightGreenAccent');
      } else {
      return Image.asset('images/brick_L_green.png');
      }  
    }

  Color colorPicker(Entry entry) {
    if (entry.category == 'Skills') {
      return Colors.indigo;
    } else if (entry.category == 'Mind') {
      return Colors.purple;
    } else if (entry.category == 'Sports') {
      return Colors.green;
    } else if (entry.category == 'Social') {
      return Colors.cyan;
    } else if (entry.category == 'Diet') {
      return Colors.yellowAccent;
    } else if (entry.category == 'Clean') {
      return Colors.lightBlue;
    } else if (entry.category == 'Abstain') {
      return Colors.red;
    } else if (entry.category == 'Career') {
      return Colors.teal;
    } else if (entry.category == 'Finances') {
      return Colors.lightGreenAccent[400];
    } else if (entry.category == 'Hustle') {
      return Colors.black87;
    } else if (entry.category == 'Romance') {
      return Colors.pink[300];
    } else {
      return Colors.blue;
    }}
  
  @override
  Widget build(BuildContext context) {

    double percent = entry.count > 0 ? entry.count.toDouble() : 0;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(getIconUsingPrefix(name: entry.icon ?? 'fa.thumbsUp' ), color: colorPicker(entry)),
          Text(entry.name.toUpperCase(), style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20))), //TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: ),),
          Text('You have laid ' + entry.count.toString() + ' bricks'),
          IconRoundedProgressBar(
            icon: Padding(
                padding: EdgeInsets.all(8), child: brickPicker(entry)),
            theme: RoundedProgressBarTheme.green,
            margin: EdgeInsets.symmetric(vertical: 16),
            borderRadius: BorderRadius.circular(6),
            percent: percent,
),
      ],
  ),
    );
  }
}