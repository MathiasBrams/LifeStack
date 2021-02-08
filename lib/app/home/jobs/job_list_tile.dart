import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:icons_helper/icons_helper.dart';

class JobListTile extends StatefulWidget {
  const JobListTile({Key key, @required this.job, this.onTap, this.visible, this.icon, this.count, this.animation, this.category})
      : super(key: key);
  final Job job;
  final Function onTap;
  final bool visible;
  final int count;
  final String icon;
  final SlideTransition animation;
  final String category;

  @override
  _JobListTileState createState() => _JobListTileState();
}

class _JobListTileState extends State<JobListTile> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<Offset> _animation;

  String colorTest = 'green';

  Color colorPicker(Job job) {
    if (widget.job.category == 'Skills') {
      return Colors.indigo;
    } else if (widget.job.category == 'Mind') {
      return Colors.purple;
    } else if (widget.job.category == 'Sports') {
      return Colors.green;
    } else if (widget.job.category == 'Social') {
      return Colors.cyan;
    } else if (widget.job.category == 'Diet') {
      return Colors.yellowAccent;
    } else if (widget.job.category == 'Clean') {
      return Colors.lightBlue;
    } else if (widget.job.category == 'Abstain') {
      return Colors.red;
    } else if (widget.job.category == 'Career') {
      return Colors.teal;
    } else if (widget.job.category == 'Finances') {
      return Colors.lightGreenAccent[400];
    } else if (widget.job.category == 'Hustle') {
      return Colors.black87;
    } else if (widget.job.category == 'Romance') {
      return Colors.pink[300];
    } else {
      return Colors.blue;
    }}


  Color green = Colors.green;


    @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -4),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SlideTransition(
      position: _animation,
        child: Visibility(
        visible: widget.job.visible,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 5,
          child: ListTile(
            leading: Icon(getIconUsingPrefix(name: widget.job.icon ?? 'fa.thumbsUp'), color: colorPicker(widget.job)),
            title: Text(widget.job.name.toUpperCase(), style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 20))),
            onTap: widget.onTap,
            trailing: Icon(Icons.chevron_right),
    ))));
  }
}
