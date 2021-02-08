import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifestack/app/home/jobs/list_items_builder.dart';
import 'package:lifestack/app/home/jobs/entry_list_tile.dart';
import 'package:lifestack/app/home/models/entry.dart';
import 'package:lifestack/app/home/models/job.dart';
import 'package:lifestack/common_widgets/platform_alert_dialog.dart';
import 'package:lifestack/common_widgets/platform_exception_alert_dialog.dart';
import 'package:lifestack/services/database.dart';
import 'package:provider/provider.dart';

import 'job_list_tile.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key, @required this.database, this.job, this.entry})
      : super(key: key);
  final Database database;
  final Job job;
  final Entry entry;
  

  static Future<void> show(
    BuildContext context, {
    Database database,
    Job job,
  }) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(database: database, job: job),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  
  bool chosen = false;
  String _name;
  String _entryName;
  bool _visible;
  Job job1;
  int sum = 0;
  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job.name;
    }
    if (widget.entry != null) {
      _entryName = widget.entry.name;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job.name);
        }
        if (allNames.contains(_name)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different goal name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(id: id, name: _name, visible: _visible);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  Future<void> _passTask(entry) async {
        {
      try {
        final entries = await widget.database.entriesStream().first;
        final allNames = entries.map((entry) => entry.name).toList();
        if (widget.entry != null) {
          allNames.remove(widget.entry.name);
        }
        if (allNames.contains(_entryName)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different goal name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          print('1');
          final id = widget.entry?.id ?? documentIdFromCurrentDate();
          await widget.database.setEntry(entry);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  Future<void> _passJob(job) async {
        {
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job.name);
        }
        if (allNames.contains(_name)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different goal name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          print('1');
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        // title: Text(widget.job == null ? 'New Goals' : 'Edit Goals'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents(BuildContext context) {
    
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Choose your own challenges', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 22))),
            SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildForm(),
              ),
            ),
            SizedBox(height: 8),
            Text('Or go with one of ours!', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20))),
            SizedBox(height: 8),
            _chooseTask(context),
          ]
        ),
      ),
    );
  }

    

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Set your goal!'),
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) {
          _name = value;
          _visible = true;
        }
      ),
      SizedBox(height: 16)
    ];
  }

  Widget _chooseTask(BuildContext context) {
    
  //   if (chosen == false) {
  //     return _buildCategories(context);
  //   } else {
  //     return _buildTasks(context, job);
  //   }
  // }
  if (chosen == false) {
    return StreamBuilder<List<Job>>(
      stream: widget.database.categoriesStream(),
      builder: (context, snapshot) {
        
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
              child: ListItemsBuilder<Job>(
                snapshot: snapshot,
                itemBuilder: (context, job) => JobListTile(
                  job: job,
                  visible: true,
                  onTap: () {
                    setState(() {
                      chosen = true;
                      job1 = job;
                      print(job1);
                    });
                    },
                  
                ),
              ),
            ),
        );
      } );
      }else {
        print(job1);
        return _buildTasks(context, job1);
      }

  }
  

  Widget _buildTasks(BuildContext context, Job job1) {
    chosen = false;
    
    return StreamBuilder<List<Entry>>(
      
      stream: widget.database.tasks2Stream(job: job1),
      builder: (context, snapshot) {
        
        // for loop to gather counts
        // for(var i = 1; i < snapshot.data.length; i++) {
        //   sum += snapshot.data[i].count;}
        //   print('this new' + snapshot.data.length.toString()); 
        //   return Container(); 
        // }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
              child: ListItemsBuilder<Entry>(
                snapshot: snapshot,
                itemBuilder: (context, entry) =>
                EntryListTile(
                  entry: entry,
                  onTap: () {print(widget.database.tasks2Stream);
                  widget.database.setJob(job1);
                  _passTask(entry);} ,
                  visible: true,
                )
              ),
            ),
        );
      },
    );
  }



}
