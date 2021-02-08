
import 'package:flutter/material.dart';
import 'package:lifestack/app/home/account/account_page.dart';
import 'package:lifestack/app/home/entries/entries_page.dart';
import 'package:lifestack/app/home/jobs/jobs_page.dart';
import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    JobsPage(),
    EntriesPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: Duration(milliseconds: 1200),
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pageList[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (int newValue) {
          setState(() {
            pageIndex = newValue;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text('Present'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.clear_all),
            title: Text('Past'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Future'),
          ),
        ],
      ),
    );
  }
}



// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TabItem _currentTab = TabItem.jobs;

//   final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
//     TabItem.jobs: GlobalKey<NavigatorState>(),
//     TabItem.entries: GlobalKey<NavigatorState>(),
//     TabItem.account: GlobalKey<NavigatorState>(),
//   };

//   Map<TabItem, WidgetBuilder> get widgetBuilders {
//     return {
//       TabItem.jobs: (_) => JobsPage(),
//       TabItem.entries: (context) => EntriesPage(),
//       TabItem.account: (_) => AccountPage(),
//     };
//   }

//   void _select(TabItem tabItem) {
//     if (tabItem == _currentTab) {
//       // pop to first route
//       navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
//     } else {
//       setState(() => _currentTab = tabItem);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
//       child: CupertinoHomeScaffold(
//         currentTab: _currentTab,
//         onSelectTab: _select,
//         widgetBuilders: widgetBuilders,
//         navigatorKeys: navigatorKeys,
//       ),
//     );
//   }

// }
