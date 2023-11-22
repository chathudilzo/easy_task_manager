import 'package:hive/hive.dart';
  part 'task.g.dart';


@HiveType(typeId: 1)
class Task extends HiveObject{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late DateTime createdTime;

  @HiveField(3)
  late bool isCompleted;

  Task(this.title,this.description,this.isCompleted,this.createdTime);
}