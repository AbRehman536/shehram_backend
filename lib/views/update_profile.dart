import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shehram_backend/models/user.dart';
import 'package:shehram_backend/services/user.dart';

import '../provider/user_provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        TextField(controller: phoneController,),
        TextField(controller: addressController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await UserServices().updateUser(
                  UserModel(
                    name: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    docId: userProvider.getUser().docId.toString()
                  )
                ).then((val)async{
                  UserModel userData = await UserServices().getUserByID(
                    userProvider.getUser().docId.toString());
                  userProvider.setUser(userData);
                }).then((value){
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
                  }, );
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));

              }
        }, child: Text("Update Profile"))
      ],),
    );
  }
}
