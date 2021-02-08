import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifestack/app/home/models/quote.dart';


class QuoteTile extends StatefulWidget {
  const QuoteTile({Key key, @required this.quote})
      : super(key: key);
  final Quote quote;


  @override
  _QuoteTileState createState() => _QuoteTileState();
}

class _QuoteTileState extends State<QuoteTile> {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(widget.quote.quote, textAlign: TextAlign.center, style: GoogleFonts.poppins()),
              SizedBox(height: 8),
              Text(widget.quote.author),
          ],),
        )
      ),
    );
  }
}


// class AccountPageTileModel {
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
