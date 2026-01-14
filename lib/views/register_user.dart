import 'package:flutter/material.dart';
import 'package:shehram_backend/models/user.dart';
import 'package:shehram_backend/services/auth.dart';
import 'package:shehram_backend/services/user.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addresController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register User"),
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        TextField(controller: cpasswordController,),
        TextField(controller: addresController,),
        TextField(controller: phoneController,),
        ElevatedButton(onPressed: ()async{
          try{
            await AuthServices().registerUser(
                email: emailController.text,
                password: passwordController.text)
                .then((val)async{
                  await UserServices().createUser(UserModel(
                    docId: val.uid,
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    address: addresController.text,
                    createdAt: DateTime.now().millisecondsSinceEpoch))
                      .then((value){
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Register Successfully"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }, child: Text("Okay"))
                            ],
                          );
                        }, );
                  });
            });
          }catch(e){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Register"))
      ],),
    );
  }
}
