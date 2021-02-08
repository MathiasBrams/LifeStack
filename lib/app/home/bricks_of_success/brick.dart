import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:google_fonts/google_fonts.dart';


class Brick extends StatefulWidget {
  const Brick({Key key, this.job, this.snapshot})
      : super(key: key);
  final Job job;
  final AsyncSnapshot snapshot;

  @override
  _BrickState createState() => _BrickState();
}
class _BrickState extends State<Brick> {

  @override
  Widget build(BuildContext context) {
      return buildBrick(context);
  }
  Widget buildBrick(BuildContext context) {
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
      } else if (widget.job.category == 'Social') {
         return Image.asset('images/brick_L_teal.png');   
      } else {
      return Image.asset('images/brick_L_green.png');
      }  
    }
  }


      
    // } else if (widget.job.category == 'Diet') {
    //   return Colors.lightGreen;
    // } else if (widget.job.category == 'Career') {
    //   return Colors.teal;
    // } 

  Widget chooseBrick(BuildContext context) {
    
}

// if (widget.snapshot.hasError) {
//      return Image.asset('images/brick_template.png');
//     } else

  //   return Card(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     elevation: 5,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         Icon(getIconUsingPrefix(name: widget.job.icon ?? 'fa.thumbsUp' ), color: Colors.green),
  //         Text(widget.job.name.toUpperCase(), style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20))), //TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: ),),
  //         Text('Completed ' + widget.job.count.toString() + ' times'),
  //     ],)
  //   );
  // }




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
