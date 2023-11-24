import 'package:easy_task_manager/objects/category.dart';
import 'package:easy_task_manager/objects/task.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BoxController extends GetxController{
  var taskList=<Task>[].obs;
  var categoryList=<Category>[].obs;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeHive();
  }


  
Future<void> initializeHive()async{
  try{
    var path=await Hive.initFlutter();
    Hive.registerAdapter(CategoryAdapter());
    Hive.registerAdapter(TaskAdapter());

    var  categoriesBox=await Hive.openBox<Category>('categories');
    var  tasksBox=await Hive.openBox<Task>('tasks');

    if(categoriesBox.isEmpty){
      await categoriesBox.add(Category('Sport'));
      await categoriesBox.add(Category('Education'));
      await categoriesBox.add(Category('Business'));
      await categoriesBox.add(Category('Personal'));
    }
    categoryList.value=categoriesBox.values.toList();
    taskList.value=tasksBox.values.toList();

  }catch(error){
    print(error.toString());
  }
}

Future<void> loadCategories()async{
  try{
    var categoriesBox=await Hive.openBox<Category>('categories');
    categoryList.value=categoriesBox.values.toList();
  }catch(error){
    print(error.toString());
  }
}

Future<void> loadTasks()async{
  try{
    var tasksBox=await Hive.openBox<Task>('tasks');
    taskList.value=tasksBox.values.toList();
  }catch(error){
    print(error);
  }
}

Future<void> addTask(Category category,String title,String description)async{
  try{
    var tasksBox=await Hive.openBox<Task>('tasks');
    Task newTask=Task(title, description, false, DateTime.now());
    tasksBox.add(newTask);
    category.addTask(newTask);
    loadTasks();
  }catch(error){
    print(error.toString());
  }
}

//Future<void> addCategory()


}