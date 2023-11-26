import 'package:hive/hive.dart';
  part 'task.g.dart';


@HiveType(typeId: 1)
class Task extends HiveObject{

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late String createdTime;

  @HiveField(3)
  late bool isCompleted;

  @HiveField(4)
  late String categoryName;

  Task(this.title,this.description,this.isCompleted,this.createdTime,this.categoryName);
}