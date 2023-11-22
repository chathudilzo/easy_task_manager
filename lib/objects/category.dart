import 'package:easy_task_manager/objects/task.dart';
import 'package:hive/hive.dart';
  part 'category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject{

  @HiveField(0)
  late String name;

  @HiveField(1)
  List<Task> tasks=[];

  Category(this.name);

  void addTask(Task task){
    tasks.add(task);
  }
}