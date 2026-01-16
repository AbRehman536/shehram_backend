import 'package:flutter/material.dart';
import 'package:shehram_backend/models/task.dart';
import 'package:shehram_backend/services/task.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        TextField(controller: descriptionController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await TaskServices().createTask(
                  TaskModel(
                    name: nameController.text,
                    description: descriptionController.text,
                    isCompleted: false,
                    createdAt: DateTime.now().millisecondsSinceEpoch
                  )).then((value) {
                  isLoading = false;
                  setState(() {});
                    showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("Create Successfully"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, child: Text("Okay"))
                        ],
                      );
                    });
                });

              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
        }, child: Text("Create Task"))
      ],),
    );
  }
}
