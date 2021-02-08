import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifestack/app/home/jobs/lifeCycleEventHandler.dart';
import 'package:lifestack/app/home/models/entry.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:lifestack/common_widgets/platform_exception_alert_dialog.dart';
import 'package:lifestack/services/auth.dart';
import 'package:lifestack/services/database.dart';
import 'package:provider/provider.dart';

class EntryListTile extends StatefulWidget {
  const EntryListTile({Key key, this.entry, this.onTap, this.visible, this.icon, this.count, this.animation, this.category, this.runAnimation = false})
      : super(key: key);
  final Entry entry;
  final VoidCallback onTap;
  final bool visible;
  final int count;
  final String icon;
  final Animation<Offset> animation;
  final String category;
  final bool runAnimation;
  

  @override
  _EntryListTileState createState() => _EntryListTileState();
}

class _EntryListTileState extends State<EntryListTile> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<Offset> _animation;
  String jobId;

  


    @override
  void initState() {
    
      _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -10),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInExpo,
      )..addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        checkAnimation();        
      } 
        
    }),
    );
    super.initState();
    // WidgetsBinding.instance.addObserver(
    //     new LifecycleEventHandler(resumeCallBack: () async => _refreshContent()));
  }

  // void _refreshContent() {
  //   final database = Provider.of<Database>(context);
  //   final user = Provider.of<User>(context);
  //   print('letsgo');
  //   database.resetTasks(user.uid);
  //   database.resetAnimationTasks(user.uid);
  //   setState(() {
  //   });
      
  //     }

  void startAnimation() {
    _controller.forward();
    
  }

  void reverseAnimation() {
    _controller.reverse();
  }

  void checkAnimation() {
    _toggleVisibleTask(context, widget.entry);
  }

  void incrementJob() {
    jobId = widget.entry.category;
    _incrementJob(context, jobId);
  }

  void incrementTask() {
    _incrementTask(context, widget.entry);
  }


  @override
  void dispose() {
    _controller.dispose();
    
    super.dispose();
  }

  Color colorPicker(Entry entry) {
    if (widget.entry.category == 'Skills') {
      return Colors.indigo;
    } else if (widget.entry.category == 'Mind') {
      return Colors.purple;
    } else if (widget.entry.category == 'Sports') {
      return Colors.green;
    } else if (widget.entry.category == 'Social') {
      return Colors.cyan;
    } else if (widget.entry.category == 'Diet') {
      return Colors.yellowAccent;
    } else if (widget.entry.category == 'Clean') {
      return Colors.lightBlue;
    } else if (widget.entry.category == 'Abstain') {
      return Colors.red;
    } else if (widget.entry.category == 'Career') {
      return Colors.teal;
    } else if (widget.entry.category == 'Finances') {
      return Colors.lightGreenAccent[400];
    } else if (widget.entry.category == 'Hustle') {
      return Colors.black87;
    } else if (widget.entry.category == 'Romance') {
      return Colors.pink[300];
    } else {
      return Colors.blue;
    }}

  void _onMenuPress() {
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    } else if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.forward) {
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.reverse) {
      _controller.forward();
    }
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

  

  @override
  Widget build(BuildContext context) {
    if(widget.entry.runAnimation != null && widget.entry.runAnimation == true) {
      startAnimation();
    } else {

    }
    

    return SlideTransition(
      position: _animation,
        child: Visibility(
        visible: widget.entry.visible,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
          child: ListTile(
            leading: Icon(getIconUsingPrefix(name: widget.entry.icon ?? 'fa.thumbsUp'), color: colorPicker(widget.entry)),
            title: Text(widget.entry.name.toUpperCase(), style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 20))),
            onTap: widget.onTap,
            trailing: Image.asset('images/brick_icon.png')))
          ),
    );
  }
}
