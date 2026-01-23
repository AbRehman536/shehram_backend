import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shehram_backend/models/priority.dart';
import 'package:shehram_backend/services/priority.dart';
import 'package:shehram_backend/views/create_priority.dart';
import 'package:shehram_backend/views/get_priorities.dart';

class GetPriority extends StatelessWidget {
  const GetPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Get All Priority"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityTaskModel(), isUpdateMode: false)));
      }, child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: PriorityServices().getAllPriority(),
          initialData: [PriorityTaskModel()],
      builder: (context, child){
            List<PriorityTaskModel> priorityList = context.watch<List<PriorityTaskModel>>();

            return ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(priorityList[index].name.toString()),
                trailing: Row(
                  children: [
                    IconButton(onPressed: ()async{
                      try{
                        await PriorityServices().deletePriority(priorityList[index].docId.toString());
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePriority(model: PriorityTaskModel(), isUpdateMode: true)));
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPriorities(model: PriorityTaskModel())));
                    }, icon: Icon(Icons.arrow_forward)),
                  ],
                ),
              );
            },);
      },),
    );
  }
}
