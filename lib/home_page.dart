import 'package:easy_task_manager/controllers/box_controller.dart';
import 'package:easy_task_manager/objects/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'objects/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final BoxController boxController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        
        onPressed: (){
          _showDialog();
      },
      child: Icon(Icons.add),),
      body: 
      
         
         SingleChildScrollView(
            child: Column(
              children: [
            
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/home1.jpeg'),fit: BoxFit.cover)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 24, 23, 23),
                            borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: Text('Search for tasks'),
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black)
                              ),
                              fillColor: Colors.grey
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              _buildCategoryList(),
                _buildIncompleteTaskList(),
              ],
            ),
          
        ),
      
    );
  }

Future<void> _showDialog(){
  Rx<Category> selectedCategory=Rx<Category>(Category(''));
  RxList<DropdownMenuItem<Category>> dropDownMenuItems=<DropdownMenuItem<Category>>[].obs;
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  final BoxController boxController=Get.find();

  dropDownMenuItems.assignAll(boxController.categoryList.value.map((Category category) {
    return DropdownMenuItem(child: Text(category.name), value: category);
  }).toList());;

  selectedCategory.value = dropDownMenuItems.isNotEmpty ? dropDownMenuItems.first.value! : Category('');

  return showDialog(context: context, builder:(BuildContext context){
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 58, 58, 58),
      title: Text('Add New Task'),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Text('Select Category'),
               
            Obx(() => DropdownButton<Category>(
              value: selectedCategory.value,
              items: dropDownMenuItems,
             onChanged:(Category? newValue){
              if(newValue!=null){
              
                  selectedCategory.value=newValue;
                
              }
             }),
            ),
            ],
           ),
            TextField(
              controller: titleController,
              style: TextStyle(color: Colors.amberAccent),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                label: Text('Title',style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: descriptionController,
               style: TextStyle(color: Colors.amberAccent),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                label: Text('Description',style: TextStyle(color: Colors.white),),
              ),
            ),
            
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel')),
        TextButton(onPressed: (){
          if(titleController.text!='' && descriptionController!=''){
            boxController.addTask(selectedCategory.value, titleController.text, descriptionController.text);
          }
        }, child: Text('Submit'))
      ],
    );
  });
}

  Widget _buildCategoryList(){
    // var categoriesBox=Hive.box<Category>('categories');
    // List<Category> categories=categoriesBox.values.toList();

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:boxController.categoryList.map((category) =>InkWell(
            onTap: () {
              
            },child: Padding(padding: const EdgeInsets.all(10),child: Chip(label: Text(category.name)),),
          ) 
          ).toList(),
        ),
      
    );
  }

  Widget _buildIncompleteTaskList(){
    var tasksBox=Hive.box<Task>('tasks');
    List<Task> incompleteTasks=tasksBox.values.where((task) =>!task.isCompleted).toList();

    return 

    Column(
        children:[
          Padding(padding: const EdgeInsets.all(8),
          child: Text('Incomplete Tasks'),),
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: incompleteTasks.length,
              itemBuilder:(context,index){
                var task=incompleteTasks[index];
                return ListTile(
                  title: Text(task.title),
                  trailing: Text(task.createdTime.toString()),
                );
              } 
              
              ),
          )
        ],
      
    );
  }
}