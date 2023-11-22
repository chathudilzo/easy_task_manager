import 'package:hive/hive.dart';

class Task extends HiveObject{

  late String title;
  late String description;
  late DateTime createdTime;
  late bool isCompleted;

  Task(this.title,this.description,this.isCompleted,this.createdTime);
}