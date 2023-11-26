import 'package:easy_task_manager/controllers/box_controller.dart';
import 'package:easy_task_manager/objects/task.dart';
import 'package:easy_task_manager/task_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({super.key,required this.task});
final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    BoxController boxController=Get.find();

    return InkWell(
      onTap: () {
        Get.to(TaskPage(task: widget.task,));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width:width,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,offset: Offset(3, 2)
            )],
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 22, 21, 21)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.task_alt_rounded,color:widget.task.isCompleted? Colors.blueAccent:Colors.red,size: 30,),
                SizedBox(width: 20,),
                SizedBox(
                  width: 130,
                  child: Text(widget.task.title,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white,fontSize: 20),)),
                Checkbox(
                  checkColor: Colors.white,
                  value: widget.task.isCompleted, onChanged:(value) {
                    
                    boxController.setCompleted(widget.task);
                },),
                Expanded(child: Container()),
                IconButton(onPressed: (){
                  boxController.deleteTasks(widget.task);
                }, icon: Icon(Icons.delete,color: Colors.orange,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}