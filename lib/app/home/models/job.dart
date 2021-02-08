
import 'package:meta/meta.dart';

class Job {
  Job({@required this.id, @required this.name, this.category, this.count, this.icon, this.visible,});
  final String id;
  final String name;
  final int count;
  final String icon;
  String category;
  bool visible;
  

  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final String icon = data['icon'];
    final int count = data['count'];
    bool visible = data['visible'];
    String category = data['category'];
    

    return Job(
      id: documentId,
      name: name,
      icon: icon,
      count: count,
      visible: visible,
      category: category
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'count': count,
      'visible': visible,
      'icon': icon,
      'category': category
    };
  }
}