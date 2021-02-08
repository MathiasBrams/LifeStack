import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrickQuotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFDEE1E9),
        appBar: AppBar(
          title: Text('One small step at a time')
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            // Non Zero Question
            Align(alignment: Alignment.centerLeft, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Brick by Brick by Will Smith", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16))),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("You don't set out to build a wall. You don't say 'I'm going to build the biggest, baddest, greatest wall that's ever been built. ' You don't start there. You say 'I'm gonna lay this brick as perfectly as a brick can be laid,' and you do that every single day, and soon you have a wall.\n\nIt's difficult to take the first step when you look how big the task is. The task is never huge to me, it's always one brick”",
                    style: TextStyle(height: 1.5)
                  ),
              )),
            ),
          ],),
        )

      
    );
  }
}