import 'package:easy_task_manager/category_page.dart';
import 'package:easy_task_manager/controllers/box_controller.dart';
import 'package:easy_task_manager/objects/category.dart';
import 'package:easy_task_manager/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'objects/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final BoxController boxController=Get.find();
final TextEditingController searchController=TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //boxController.initializeHive();
  }

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
                            controller: searchController,
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
                _buildIncompleteTaskList(searchController),
              ],
            ),
          
        ),
      
    );
  }

Future<void> _showDialog(){
  Rx<Category> selectedCategory=Rx<Category>(Category('',''));
  RxList<DropdownMenuItem<Category>> dropDownMenuItems=<DropdownMenuItem<Category>>[].obs;
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

  final BoxController boxController=Get.find();

  dropDownMenuItems.assignAll(boxController.categoryList.value.map((Category category) {
    return DropdownMenuItem(child: Text(category.name), value: category);
  }).toList());;

  selectedCategory.value = dropDownMenuItems.isNotEmpty ? dropDownMenuItems.first.value! : Category('','');

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
            
            boxController.addTask(selectedCategory.value, titleController.text, descriptionController.text,);
            Navigator.pop(context);
          }
        }, child: Text('Submit'))
      ],
    );
  });
}

  Widget _buildCategoryList(){
    // var categoriesBox=Hive.box<Category>('categories');
    // List<Category> categories=categoriesBox.values.toList();
    final TextEditingController categoryController=TextEditingController();

    return Obx(() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:[...boxController.categoryList.map((category) =>InkWell(
            onTap: () {
              Get.to(CategoryPage(category: category));
            },child: Padding(padding: const EdgeInsets.all(10),child: Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
              
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage(category.img.toString()),fit: BoxFit.contain)
                    ),
                  
                  ),
                  Text('${category.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text(category.tasks.length==0?'':'+${category.tasks.length}Tasks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                ],
              ),
            ),),
          ) 
          ).toList(),
          GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  title: Text('Add Category'),
                  content: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextField(
                          
                          controller: categoryController,
                          decoration: InputDecoration(
                            label: Text('Category Name'),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(onPressed:() {
                      Navigator.pop(context);
                    }, child: Text('Cancel')),
                    TextButton(onPressed: (){
                      boxController.addCategory(categoryController.text,'assets/task.png');
                      Navigator.pop(context);
                    }, child: Text('Add')),
                    
                  ],
                );
              });
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(Icons.add),
                    Text('Category')
                  ],
                ),
              ),
            ))
          ]
        ),
      
    ));
  }

  Widget _buildIncompleteTaskList(TextEditingController controller){
    BoxController boxController=Get.find();

    

    return 

    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 48, 47, 47),
          borderRadius: BorderRadius.circular(40)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Padding(padding: const EdgeInsets.all(8),
              child: Text(controller.text!=''?'Search Tasks':'Today Tasks',style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),)),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  height: 300,
                  child: Obx(
                    (){
                      List<Task> incompleteTasks=controller.text==''?boxController.taskList.where((task) =>task.createdTime.contains(DateFormat('yyyy-MM-dd').format(DateTime.now()))).toList() :boxController.taskList.where((task) =>task.title.contains(controller.text)).toList();
                      return ListView.builder(
                      shrinkWrap: true,
                      itemCount: incompleteTasks.length,
                      itemBuilder:(context,index){
                        var task=incompleteTasks[index];
                        return TaskWidget(task: task);
                      } 
                      
                      );
                    }
                  ),
                ),
              )
            ],
          
        ),
      ),
    );
  }
}