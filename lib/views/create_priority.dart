import 'package:flutter/material.dart';
import 'package:shehram_backend/models/priority.dart';
import 'package:shehram_backend/services/priority.dart';

class CreatePriority extends StatefulWidget {
  final PriorityTaskModel model;
  final bool isUpdateMode;
  const CreatePriority({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    if(widget.isUpdateMode == true)
    nameController = TextEditingController(
        text: widget.model.name.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode ? "Update Priority" : "Create Priority"),
      ),
      body: Column(
        children: [
          TextField(controller: nameController,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  if(widget.isUpdateMode == true){
                    await PriorityServices().updatePriority(
                      PriorityTaskModel(
                        docId: widget.model.docId.toString(),
                        name: nameController.text,
                        createdAt: DateTime.now().millisecondsSinceEpoch
                      )
                    ).then((val){
                      isLoading = false;
                      setState(() {});
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Update Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );
                    });
                  });
                }else{
                    await PriorityServices().createPriority(
                        PriorityTaskModel(
                            name: nameController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch
                        )
                    ).then((val){
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
                  }

                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));

                }
          }, child: Text(
            widget.isUpdateMode ? "Update Priority" : "Create Priority"
          ))
        ],
      ),
    );
  }
}
