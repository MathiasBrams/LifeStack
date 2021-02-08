import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifestack/app/home/account/list_quote_builder.dart';
import 'package:lifestack/app/home/account/quote_brick_page.dart';
import 'package:lifestack/app/home/account/quote_nonzero_page.dart';
import 'package:lifestack/app/home/account/quote_tile.dart';
import 'package:lifestack/app/home/account/languages_page.dart';
import 'package:lifestack/app/home/account/settings_page.dart';
import 'package:lifestack/app/home/bricks_of_success/bricks_wall_page.dart';
import 'package:lifestack/app/home/entries/entries_list_tile.dart';
import 'package:lifestack/app/home/jobs/list_items_builder.dart';
import 'package:lifestack/app/home/models/quote.dart';
import 'package:provider/provider.dart';
import 'package:lifestack/common_widgets/avatar.dart';
import 'package:lifestack/common_widgets/platform_alert_dialog.dart';
import 'package:lifestack/services/auth.dart';
import 'package:lifestack/services/database.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final database = Provider.of<Database>(context);
    final user = Provider.of<User>(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.settings), onPressed: () {
              SettingsScreen.show(context, database: Provider.of<Database>(context), user: Provider.of<User>(context));
            },),
          ],
          title: Text(
                user.displayName != null ? user.displayName : '',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: _buildUserInfo(user),
          ),),
        body: _buildContents(context)
    );
  }

  Widget _buildContents(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Align(alignment: Alignment.centerLeft, child: Text('Wisdom', style: TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(height: 8),
              Row(children: <Widget> [ Padding(
                padding: const EdgeInsets.all(8.0),
                child: OpenContainer(
                  closedElevation: 5,
                  transitionDuration: Duration(milliseconds: 1000),
                  closedBuilder: (context, action) {
                    return NonZeroQuoteBox();},
                  openBuilder: (context, action) {
                    return NonZeroQuotePage();
                    // return QuotePage();
                  },),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OpenContainer(
                  closedElevation: 5,
                  transitionDuration: Duration(milliseconds: 1000),
                  closedBuilder: (context, action) {
                    return BrickQuoteBox();},
                  openBuilder: (context, action) {
                    return BrickQuotePage();
                    // return QuotePage();
                  },),
              ),],),
              SizedBox(height: 20),
              Align(child: Text('Quotes of the day', style: TextStyle(fontWeight: FontWeight.bold)), alignment: Alignment.centerLeft,),
              SizedBox(height: 8),
              _buildCarousel(context),
            ]
          ),
        ),
    );
  }

  // Widget _buildQuotes(BuildContext context) {
  //   final database = Provider.of<Database>(context);

  //   return StreamBuilder<List<Quote>>(
  //     stream: database.quotesStream(),
  //     builder: (context, snapshot) {
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: ListItemsBuilder<Quote>(
  //           snapshot: snapshot,
  //           itemBuilder: (context, quote) => QuoteTile(
  //             quote: quote
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildCarousel(BuildContext context) {
    final database = Provider.of<Database>(context);

    return StreamBuilder<List<Quote>>(
      stream: database.quotesStream(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListQuoteBuilder<Quote>(
            snapshot: snapshot,
            itemBuilder: (context, quote) => QuoteTile(
              quote: quote
            ),
          ),
        );
      },
    );
  }

  Widget _carousel() {
    return CarouselSlider(
    options: CarouselOptions(height: 200.0),
    items: [1,2,3,4,5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.amber
            ),
            child: Text('text $i', style: TextStyle(fontSize: 16.0),)
          );
        },
      );
    }).toList(),
  );
  }
}

Widget _buildUserInfo(User user) {
    return Align(
      alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
          child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Avatar(
              photoUrl: user.photoUrl,
              radius: 50,
            ),
            SizedBox(width: 8),
            
            Column(children: <Widget>[
              if (user.displayName != null)
              Text(
                user.displayName,
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
            Text('Level: Brick Smith', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.normal)),
            ],)
            ]),
            RoundedProgressBar(theme: RoundedProgressBarTheme.green)
          ],
      ),
        ),
    );
  }


class NonZeroQuoteBox extends StatelessWidget {
  const NonZeroQuoteBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: SizedBox(height: 100, width: MediaQuery.of(context).size.width * 0.40,
       child: Padding(
         padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                 child: Align(
                   alignment: Alignment.center,
                   child: Text('Non Zero', textAlign: TextAlign.center, style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20))),
                   ),
                 ),
       ),
    );
  }
}
  class BrickQuoteBox extends StatelessWidget {
    const BrickQuoteBox({
      Key key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Expanded(
              child: SizedBox(height: 100, width: MediaQuery.of(context).size.width * 0.45,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Brick by Brick',  textAlign: TextAlign.center, style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20),)),
                    ),
                  ),
        ),
      );
    }


  



}