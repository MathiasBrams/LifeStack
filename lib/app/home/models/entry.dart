import 'package:flutter/foundation.dart';

class Entry {
  Entry({
    @required this.id,
    @required this.jobId,
    this.name, this.count, this.icon, this.visible, this.category, this.runAnimation
  });

  String id;
  String jobId;
  final String name;
  int count;
  final String icon;
  bool visible;
  String category;
  bool runAnimation;



  factory Entry.fromMap(Map<dynamic, dynamic> value, String id) {
    return Entry(
      id: id,
      jobId: value['jobId'],
      name: value['name'],
      count: value['count'],
      icon: value['icon'],
      visible: value['visible'],
      category: value['category'],
      runAnimation: value['runAnimation']
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobId': jobId,
      'name': name,
      'count': count,
      'icon': icon,
      'visible': visible,
      'category': category,
      'runAnimation': runAnimation
    };
  }
}
