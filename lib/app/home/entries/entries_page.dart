import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lifestack/app/home/achievements/medals_page.dart';
import 'package:lifestack/app/home/achievements/walls_stats_page.dart';
import 'package:lifestack/app/home/jobs/entry_list_tile.dart';
import 'package:lifestack/app/home/models/entry.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:provider/provider.dart';
import 'package:lifestack/app/home/entries/house.dart';
import 'package:lifestack/app/home/entries/entries_list_tile.dart';
import 'package:lifestack/app/home/jobs/list_items_builder.dart';
import 'package:lifestack/services/database.dart';

import 'grid_items_builder.dart';

class EntriesPage extends StatefulWidget {

  @override
  _EntriesPageState createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  int wallsBuilt1 = 0;
  int wallsBuilt = 0;
 @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Accomplishments', style: TextStyle(fontWeight: FontWeight.w600)),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(text: 'Bricks'),
            Tab(text: 'Walls'),
            Tab(text: 'Medals'),
          ],
        )
      ),
      body: TabBarView(children: <Widget>[
        _buildContents(context),
        WallStats(),
        Achievements(),
      ],)
      
      
    ));
  }

  Widget _buildContents(BuildContext context) {
    
    return Container(
      height: 1000,
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("images/brick_background.png"),
      //       fit: BoxFit.cover)),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[            

              // Code to implement build house in stages and button to trigger it

              // buildHouse(context, wallsBuilt),
              // RaisedButton(
              //   onPressed: () {
              //     setState(() {
              //       wallsBuilt = wallsBuilt +1;
              //       buildHouse(context, wallsBuilt);
              //       print(wallsBuilt);
              //     });
              //   }
              // ),
              _buildStats(context),],)
    ));
  }

  Widget buildHouse(BuildContext context, int wallsBuilt) {
        
    if (wallsBuilt == null || wallsBuilt == 0) {
      return Image.asset('images/house_start.png');
      } else if (wallsBuilt == 1) {
        return Image.asset('images/house_foundation.png');
      } else if (wallsBuilt == 2) {
        return Image.asset('images/house_finished.png');
    } else {
        return Image.asset('images/house_finished.png');
    }
  }

  Widget _buildStats(BuildContext context) {
    final database = Provider.of<Database>(context);

    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: EntriesListTile(
              job: job,
              database: database,
            ),
          ),
        );
      },
    );
  }
}
  // static Widget create(BuildContext context) {
  //   final database = Provider.of<Database>(context);
  //   return Provider<Database>(
  //     create: (_) => EntriesBloc(database: database),
  //     child: EntriesPage(),
  //   );
  // }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Entries'),
//         elevation: 2.0,
//       ),
//       body: _buildContents(context),
//     );
//   }

//   Widget _buildContents(BuildContext context) {
//     final database = Provider.of<Database>(context);
//     return StreamBuilder<List<Job>>(
//       stream: database.jobsStream(),
//       builder: (context, snapshot) {
//         return ListItemsBuilder<Job>(
//           snapshot: snapshot,
//           itemBuilder: (context, job) => EntriesListTile(job: job),
//         );
//       },
//     );
//   }
// }
