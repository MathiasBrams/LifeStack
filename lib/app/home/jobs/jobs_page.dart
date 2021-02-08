import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifestack/app/home/bricks_of_success/bricks_wall_page.dart';
import 'package:lifestack/app/home/entries/entries_page.dart';
import 'package:lifestack/app/home/jobs/entry_list_tile.dart';
import 'package:lifestack/app/home/jobs/lifeCycleEventHandler.dart';
import 'package:lifestack/app/home/models/entry.dart';
import 'package:lifestack/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:lifestack/app/home/job_entries/job_entries_page.dart';
import 'package:lifestack/app/home/jobs/edit_job_page.dart';
import 'package:lifestack/app/home/jobs/job_list_tile.dart';
import 'package:lifestack/app/home/jobs/list_items_builder.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:lifestack/common_widgets/platform_exception_alert_dialog.dart';
import 'package:lifestack/services/database.dart';

class JobsPage extends StatefulWidget {
  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage>
    with SingleTickerProviderStateMixin {
  SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;
  bool _isLoggedIn = false;
  AnimationController _controller;
  Animation<Offset> _animation;
  Animation<double> _menuAnimation;

  @override
  void initState() {
    _initAnimation();
    super.initState();

    WidgetsBinding.instance.addObserver(
        new LifecycleEventHandler(resumeCallBack: () async => _refreshContent()));
        
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _refreshState() {
    setState(() {
    });
  }

  void _refreshContent() async {
    final database = Provider.of<Database>(context);
    final user = Provider.of<User>(context);
    print('letsgo');
    
      // await database.resetTasks(user.uid);
      await database.resetAnimationTasks(user.uid);
      _refreshState();
  }

  void _onMenuPress() async {
    if (_controller.status == AnimationStatus.dismissed) {
      await _controller.forward();
      EditJobPage.show(context, database: Provider.of<Database>(context));
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.forward) {
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.reverse) {
      _controller.forward();
    }
  }


  

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _controller.addListener((){
		  setState((){});
	  });

    

    _animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -4),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );

    _menuAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
  }

  Future<void> _incrementJob(BuildContext context, String jobId) async {
    try {
      final database = Provider.of<Database>(context);
      await database.incrementJob(jobId);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  Future<void> _incrementTask(BuildContext context, Entry entry) async {
    try {
      final database = Provider.of<Database>(context);
      await database.incrementTask(entry);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  Future<void> _runAnimation(BuildContext context, Entry entry) async {
    try {
      final database = Provider.of<Database>(context);
      await database.startAnimation(entry);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  Future<void> _toggleVisibleJob(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context);
      await database.toggleVisibleJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  Future<void> _toggleVisibleTask(BuildContext context, Entry entry) async {
    try {
      final database = Provider.of<Database>(context);
      await database.toggleVisibleTask(entry);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  void _toggleLoginStatus() {
    setState(() {
      _isLoggedIn = !_isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('LifeStack', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: _onMenuPress,
              icon: AnimatedIcon(
                  progress: _menuAnimation, icon: AnimatedIcons.add_event))
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(children: <Widget>[
        Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Make today a great day. Place a brick!',
                      style: GoogleFonts.poppins()),
                ),
                bricksWall(context),
              ],
            )),
        _buildJobs(context),
      ]),
    );
  }

  Widget _buildJobs(BuildContext context) {
    final database = Provider.of<Database>(context);
    String jobId;
    

    return StreamBuilder<List<Entry>>(
      stream: database.entryStream(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListItemsBuilder<Entry>(
            snapshot: snapshot,
            itemBuilder: (context, entry) => EntryListTile(
              entry: entry,
              visible: true,
              animation: _animation,
              onTap: () {
                
                jobId = entry.category;
                entry.runAnimation = true;

                _runAnimation(context, entry);
                print(_controller.value);
                // _toggleVisibleTask(context, entry);

                // delay to time the brick placement with the finished animation
                Future.delayed(Duration(milliseconds: 1000), () {
                  _incrementJob(context, jobId);
                  _incrementTask(context, entry);
              });},
            ),
          ),
        );
      },
    );
  }
}
// IconButton(
//  onPressed: _onMenuPress,
//  icon: AnimatedIcon(
//    progress: _menuAnimation,
//    icon: AnimatedIcons.add_event,))
