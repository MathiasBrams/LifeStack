import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rounded_progress_bar/flutter_icon_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:lifestack/app/home/bricks_of_success/brick.dart';
import 'package:lifestack/app/home/entries/stats_list_tile.dart';
import 'package:lifestack/app/home/jobs/entry_list_tile.dart';
import 'package:lifestack/app/home/jobs/list_items_builder.dart';
import 'package:lifestack/app/home/models/entry.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifestack/services/database.dart';
import 'package:provider/provider.dart';



class EntriesListTile extends StatefulWidget {
  const EntriesListTile({Key key, @required this.job, this.database})
      : super(key: key);
  final Job job;
  final Database database;

  @override
  _EntriesListTileState createState() => _EntriesListTileState();
}

class _EntriesListTileState extends State<EntriesListTile> {

  Widget brickPicker(Job job) {
    if (widget.job == null) {
        return Image.asset('images/brick_template.png');
      } else if (widget.job.category == null) {
        return Image.asset('images/brick_template.png');
      } else if (widget.job.category == 'Mind') {
        return Image.asset('images/brick_L_purple.png');
      } else if (widget.job.category == 'Skills') {
        return Image.asset('images/brick_L_blue.png');
      } else if (widget.job.category == 'Abstain') {
        return Image.asset('images/brick_L.png');
      } else if (widget.job.category == 'Sports') {
        return Image.asset('images/brick_L_green.png');
      } else if (widget.job.category == 'Hustle') {
         return Image.asset('images/brick_L_black.png');
      } else if (widget.job.category == 'Romance') {
         return Image.asset('images/brick_L_pink.png');
      } else if (widget.job.category == 'Clean') {
         return Image.asset('images/brick_L_teal.png');
      } else if (widget.job.category == 'Career') {
         return Image.asset('images/brick_L_cyan.png');
      } else if (widget.job.category == 'Diet') {
         return Image.asset('images/brick_L_yellowAccent.png');
      } else if (widget.job.category == 'Finances') {
         return Image.asset('images/brick_L_lightGreenAccent');
      } else {
      return Image.asset('images/brick_L_green.png');
      }  
    }

  Color colorPicker(Job job) {
    if (widget.job.category == 'Skills') {
      return Colors.indigo;
    } else if (widget.job.category == 'Mind') {
      return Colors.purple;
    } else if (widget.job.category == 'Sports') {
      return Colors.green;
    } else if (widget.job.category == 'Social') {
      return Colors.cyan;
    } else if (widget.job.category == 'Diet') {
      return Colors.yellowAccent;
    } else if (widget.job.category == 'Clean') {
      return Colors.lightBlue;
    } else if (widget.job.category == 'Abstain') {
      return Colors.red;
    } else if (widget.job.category == 'Career') {
      return Colors.teal;
    } else if (widget.job.category == 'Finances') {
      return Colors.lightGreenAccent[400];
    } else if (widget.job.category == 'Hustle') {
      return Colors.black87;
    } else if (widget.job.category == 'Romance') {
      return Colors.pink[300];
    } else {
      return Colors.blue;
    }}

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: OpenContainer(
        transitionDuration: Duration(milliseconds: 600),
        closedBuilder: (context, action) {
          return buildCard(); },
        openBuilder: (context, action) {
          return buildCardLVL2(context, widget.job); }
        )),
    );
  }

  Padding buildCard() {
    double percent = widget.job.count.toDouble();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(getIconUsingPrefix(name: widget.job.icon ?? 'fa.thumbsUp' ), size: 32, color: colorPicker(widget.job)),
          SizedBox(height: 5),
          Text(widget.job.name.toUpperCase(), style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20))), //TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: ),),
          Text('You have laid ' + widget.job.count.toString() + ' bricks'),
          IconRoundedProgressBar(
            icon: Padding(
                padding: EdgeInsets.all(8), child: brickPicker(widget.job)),
            theme: RoundedProgressBarTheme.green,
            margin: EdgeInsets.symmetric(vertical: 16),
            borderRadius: BorderRadius.circular(6),
            percent: percent,
),
      ],
  ),
    );
  }

  Widget buildCardLVL2(BuildContext context, Job job) {

    return StreamBuilder<List<Entry>>(
      
      stream: widget.database.entriesStream(job: job),
      builder: (context, snapshot) {

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: ListView(children: <Widget> [
              Text(job.name, textAlign: TextAlign.center, style: GoogleFonts.poppins(textStyle: TextStyle(fontSize:48))),
              SizedBox(height: 5),
              Icon(getIconUsingPrefix(name: widget.job.icon ?? 'fa.thumbsUp'), size: 40, color: colorPicker(widget.job)),
              SizedBox(height: 20),
              ListItemsBuilder<Entry>(
                snapshot: snapshot,
                itemBuilder: (context, entry) =>
                StatsListTile(
                  entry: entry,
                )
              ),
            ]),)
        );
      },
    );
  }

}



// class EntriesListTileModel {
//   const EntriesListTileModel({
//     @required this.leadingText,
//     @required this.trailingText,
//     this.middleText,
//     this.isHeader = false,
//   });
//   final String leadingText;
//   final String trailingText;
//   final String middleText;
//   final bool isHeader;
// }

// class EntriesListTile extends StatelessWidget {
//   const EntriesListTile({@required this.model});
//   final EntriesListTileModel model;

//   @override
//   Widget build(BuildContext context) {
//     const fontSize = 16.0;
//     return Container(
//       color: model.isHeader ? Colors.indigo[100] : null,
//       padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Row(
//         children: <Widget>[
//           Text(model.leadingText, style: TextStyle(fontSize: fontSize)),
//           Expanded(child: Container()),
//           if (model.middleText != null)
//             Text(
//               model.middleText,
//               style: TextStyle(color: Colors.green[700], fontSize: fontSize),
//               textAlign: TextAlign.right,
//             ),
//           SizedBox(
//             width: 60.0,
//             child: Text(
//               model.trailingText,
//               style: TextStyle(fontSize: fontSize),
//               textAlign: TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
