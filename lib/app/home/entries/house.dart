import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:google_fonts/google_fonts.dart';


class House extends StatefulWidget {
  const House({Key key, this.wallsBuilt})
      : super(key: key);
  final int wallsBuilt;

  @override
  _HouseState createState() => _HouseState();
}
class _HouseState extends State<House> {
  final int wallsBuilt = 0;
  @override
  Widget build(BuildContext context) {
    print('test' + wallsBuilt.toString());
      return buildHouse(context);
  }
  Widget buildHouse(BuildContext context) {
    print('test2' + wallsBuilt.toString());  
        
    if (wallsBuilt == null || wallsBuilt == 0) {
      return Image.asset('images/house_start.png');
      } else if (wallsBuilt == 1) {
        return Image.asset('images/house_foundation.png');
      } else {
        return Image.asset('images/house_finished.png');
    }
  }
}

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
