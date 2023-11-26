import 'package:easy_task_manager/controllers/box_controller.dart';
import 'package:easy_task_manager/objects/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskPage extends StatefulWidget {
   TaskPage({super.key,required this.task});
  Task task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    final BoxController boxController=Get.find();
    
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Obx((){
        if(boxController.taskList.contains(widget.task)){
          return SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(10)
                ),
                child: Image.asset('assets/taskback.jpeg',height: 280,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                ),
              ),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               IconButton(onPressed: (){
                boxController.deleteTasks(widget.task);
               }, icon: Icon(Icons.delete,size: 40,color: Colors.orange,)),
               Text('Completed: ',style: TextStyle(color: Colors.white),),
               Checkbox(value: widget.task.isCompleted, onChanged:(value){
                  boxController.setCompleted(widget.task);
               } )
              ],
             ),
          
          
             Text('Task',style: TextStyle(fontSize: 26,color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                Text(widget.task.title,style: TextStyle(color: const Color.fromARGB(255, 207, 206, 206),fontSize: 22),),
              SizedBox(height: 25,),
              
              Text('Category',style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
              Text(widget.task.categoryName,style: TextStyle(color: const Color.fromARGB(255, 207, 206, 206),fontSize: 22),),
              
              SizedBox(height: 10,),
              Text('Date',style: TextStyle(fontSize: 26,color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
              Text(widget.task.createdTime.toString(),style: TextStyle(color: const Color.fromARGB(255, 207, 206, 206),fontSize: 22),),
             SizedBox(height: 10,),
             Row(
              children: [
                Text('Completed:',style: TextStyle(fontSize: 26,color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                Chip(label: Text(widget.task.isCompleted?'Yes':'No'),avatar: CircleAvatar(backgroundColor:widget.task.isCompleted?Colors.blueAccent:Colors.redAccent),)
              ],
             ),
          
          
              SizedBox(height: 10,),
              Text('Description',style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
              Text(widget.task.description,style: TextStyle(color: const Color.fromARGB(255, 207, 206, 206),fontSize: 22),)
            ],
                  ),
          );
        }else{
          return Center(
            child: Text('Task Removed',style: TextStyle(color: Colors.white,fontSize: 36),),
          );
        }
      })
       ,
      
    );
  }
}