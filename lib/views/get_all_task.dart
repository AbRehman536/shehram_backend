import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shehram_backend/models/task.dart';
import 'package:shehram_backend/services/task.dart';
import 'package:shehram_backend/views/get_completed.dart';
import 'package:shehram_backend/views/get_favorite.dart';
import 'package:shehram_backend/views/get_incompleted.dart';
import 'package:shehram_backend/views/get_priority.dart';
import 'package:shehram_backend/views/get_profile.dart';
import 'package:shehram_backend/views/update_task.dart';

import '../provider/user_provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetPriority()));
          }, icon: Icon(Icons.category)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetFavorite()));
          }, icon: Icon(Icons.favorite)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCompleted()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetInCompleted()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetProfile()));
          }, icon: Icon(Icons.person)),
        ],
      ),
      body: StreamProvider.value(
          value: TaskServices().getAllTask(),
          initialData: [TaskModel()],
        builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[index].name.toString()),
                subtitle: Text(taskList[index].description.toString()),
                trailing: Row(
                  children: [
                    Checkbox(
                        value: taskList[index].isCompleted,
                        onChanged: (val)async{
                          await TaskServices().markAsCompletedTask(
                              taskID: taskList[index].docId.toString(),
                              isCompleted: val!);
                        }),
                    IconButton(onPressed: ()async{
                      if(taskList[index].favorite!.contains(userProvider.getUser().docId.toString())){
                        await TaskServices().removeFromFavorite(
                            userID: userProvider.getUser().docId.toString(),
                            taskID: taskList[index].docId.toString());
                      }
                      else{
                        TaskServices().addToFavorite(
                            userID: userProvider.getUser().docId.toString(),
                            taskID: taskList[index].docId.toString());
                      }
                    }, icon: Icon(taskList[index].favorite!.contains(userProvider.getUser().docId.toString()) ? Icons.favorite : Icons.favorite_border)),
                    IconButton(onPressed: ()async{
                      try{
                        await TaskServices().deleteTask(taskList[index].docId.toString());
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(model: taskList[index])));
                    }, icon: Icon(Icons.edit_calendar))
                  ],
                )
              );
            },);
        },
      ),
    );
  }
}
