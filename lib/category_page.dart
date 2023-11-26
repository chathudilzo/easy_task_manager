import 'package:easy_task_manager/controllers/box_controller.dart';
import 'package:easy_task_manager/objects/category.dart';
import 'package:easy_task_manager/objects/task.dart';
import 'package:easy_task_manager/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key,required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final BoxController controller=Get.find();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(category.name,style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
                ],
              ),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(category.img.toString()),fit: BoxFit.cover)
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 400,
                child: Center(
                  child: Obx((){
                    List<Task> tasks=controller.taskList.where((task) => task.categoryName==category.name).toList();
                    
                    return tasks.isEmpty?Text('No Tasks to show',
                    style: TextStyle(color: Colors.white,fontSize: 20,
                    fontWeight: FontWeight.bold),):
                    
                    ListView.builder(
                      shrinkWrap: true,
                  itemCount: tasks.length,
                  reverse:true,
                  itemBuilder: (BuildContext context,index){
                  return TaskWidget(task: tasks[index]);
                              });
                  }),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}