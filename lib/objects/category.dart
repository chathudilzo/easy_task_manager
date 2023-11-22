import 'package:easy_task_manager/objects/task.dart';
import 'package:hive/hive.dart';

class Category extends HiveObject{

  late String name;

  List<Task> tasks=[];

  Category(this.name);

  void addTask(Task task){
    tasks.add(task);
  }
}