import 'package:flutter/material.dart';
import 'package:lifestack/app/home/bricks_of_success/brick.dart';
import 'package:lifestack/app/home/bricks_of_success/list_bricks_builder.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:lifestack/services/database.dart';
import 'package:provider/provider.dart';


bricksWall(BuildContext context) async {
  
  

  final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        List<Job> brick = [];

        for(var i = 0; i < snapshot.data.length; i++){
        brick.add(snapshot.data[i]);
    }


        // for loop gennem antal af bricks og deres counts, som så tilføjes til newBricks liste
        List<Brick> newBricks = [];

        for(var i = 0; i < brick.length; i++) { // 3 bricks
          for (var x = 0; x < brick[i].count; x++) {
          newBricks.add(Brick(job: brick[i]));
        }}


        // newBricks listen fyldes op med tomme bricks til og med 35 stk (fuld column),
        // hvis den ikke er fyldt selv
        // for den første wall

        
      if (newBricks.length < 35) {
        for(var i = 35; newBricks.length < i;){
            newBricks.add(Brick());
          }}

        // for den anden wall
      if (35 < newBricks.length && newBricks.length < 70) {
        for(var i = 70; newBricks.length < i;){
            newBricks.add(Brick());
          }
      }
        List<Brick> newWall1 = [];
        List<Brick> newWall2 = [];

      // hvis newBricks er mindre end eller lig 35, så flyttes de bricks over i newWall1 liste  
      // OBS PROGRAM CRASHER INDEN HER, PRINTS KOMMER IKKE
        if (newBricks.length <= 35) {
          for(var i=0; i < 35; i++) {
            newWall1.add(newBricks[i]);
        }}

      // hvis newBricks er mellem 36 og 70, så flyttes de bricks over i newWall2 liste    
        if (35 < newBricks.length && newBricks.length <= 70) {
          for(var i=35; i < 70; i++) {
            newWall2.add(newBricks[i]);
          }}

      // wallSelector vælger hvilken liste der skal vises, depending on  newbricks længde  

      Brick wallSelector(i) {
        if (newBricks.length <= 35) {
        return newWall1[i];
      } else if (35 < newBricks.length && newBricks.length <= 70) {
        return newWall2[i];
        
      } else {
        return Brick();
      }}



        
        
       // if (!snapshot.hasData) {
        //   return Brick(job: snapshot.data[0]);
        // }


    return Column(  
      mainAxisSize: MainAxisSize.min,
      
      children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            wallSelector(34),
            wallSelector(33),
            wallSelector(32),
            wallSelector(31),
            wallSelector(30),            
            ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            wallSelector(29),
            wallSelector(28),
            wallSelector(27),
            wallSelector(26),
            wallSelector(25),            
            ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            wallSelector(24),
            wallSelector(23),
            wallSelector(22),
            wallSelector(21),
            wallSelector(20),            
            ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            wallSelector(19),
            wallSelector(18),
            wallSelector(17),
            wallSelector(16),
            wallSelector(15),           
            ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            wallSelector(14),
            wallSelector(13),
            wallSelector(12),
            wallSelector(11),
            wallSelector(10),            
            ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            wallSelector(9),
            wallSelector(8),
            wallSelector(7),
            wallSelector(6),
            wallSelector(5),            ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            wallSelector(4),
            wallSelector(3),
            wallSelector(2),
            wallSelector(1),
            wallSelector(0),
            ]),
          ]);
        
        
        
        
      
        });
}
        // ListBrickBuilder<Job>(
        //     snapshot: snapshot,
        //     itemBuilder: (context, job) => Brick(
        //       job: job,
        //     )
        // );

  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
      
  //     children: <Widget>[
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick()
  //           ]),
          
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           ]),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //           Brick(),
  //   ])]);
  // }


  // static String redBrick() => 'images/brick_L';
  // static String blueBrick() => 'images/brick_L_blue';
  // static String greenBrick() => 'images/brick_L_green';
  // static String purpleBrick() => 'images/brick_L_purple';
