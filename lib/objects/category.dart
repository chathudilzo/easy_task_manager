import 'package:easy_task_manager/objects/task.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
  part 'category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject{

  @HiveField(0)
  late String name;

  @HiveField(1)
  List<Task> tasks=[];

  @HiveField(2)
  String? img;
  Category(this.name,this.img);

  void addTask(Task task){
    tasks.add(task);
  }

  void clearTasks(){
    tasks.clear();
  }
}
