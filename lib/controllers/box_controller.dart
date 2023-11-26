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
    
    // await categoriesBox.clear();
    // await tasksBox.clear();

  print(categoriesBox.values.toString());
    if(categoriesBox.isEmpty){
      await categoriesBox.add(Category('Sport','assets/sport.png'));
      await categoriesBox.add(Category('Coding','assets/code.png'));
      await categoriesBox.add(Category('Education','assets/edu.png'));
      await categoriesBox.add(Category('Business','assets/business.png'));
      await categoriesBox.add(Category('Personal','assets/personal.png'));
    }
    categoryList.value=categoriesBox.values.toList();
    print(categoryList);
    
    taskList.value=tasksBox.values.toList();
    print(taskList);
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

    Task newTask=Task(title, description, false, DateTime.now(),category.name);

    tasksBox.add(newTask);
    
    updateTasksInCategories();
    loadTasks();
    print(taskList);
  }catch(error){
    print(error.toString());
  }
}

Future<void> updateTasksInCategories()async{
  try{
    var tasksBox=await Hive.openBox<Task>('tasks');
    var categoriesBox=await Hive.openBox<Category>('categories');

      for(var category in categoriesBox.values){
        category.clearTasks();
        await category.save();
      }

      for(int i=0;i<tasksBox.length;i++){
        Task task=tasksBox.getAt(i) as Task;

        Category? category=categoriesBox.values.firstWhere((category) => category.name==task.categoryName,orElse: null);

        if(category!=null){
          category.addTask(task);
          await category.save();
        }
      }

  }catch(error){
    print(error.toString());
  }
}



Future<void> addCategory(String name,String img)async{
try{
  var categoriesBox=await Hive.openBox<Category>('categories');
  Category newCategory=Category(
    name,
    img

  );
  categoriesBox.add(newCategory);
  loadCategories();
}catch(error){
  print(error.toString());
}
}

Future<void> setCompleted(Task updatedTask)async{
  try{
    updatedTask.isCompleted=!updatedTask.isCompleted;
    var tasksBox=await Hive.openBox<Task>('tasks');
    
    print(updatedTask.key);
    int index=taskList.indexWhere((task) =>task.key==updatedTask.key);
    if(index!=-1){
      
      await tasksBox.putAt(index, updatedTask);
      updateTasksInCategories();
      
      loadTasks();
    }

  }catch(error){
    print(error.toString());
  }
}


}