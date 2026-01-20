import 'package:flutter/material.dart';
import 'package:shehram_backend/services/auth.dart';
import 'package:shehram_backend/views/get_all_task.dart';
import 'package:shehram_backend/views/register_user.dart';
import 'package:shehram_backend/views/reset_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        ElevatedButton(onPressed: ()async{
          try{
            await AuthServices().loginUser(
                email: emailController.text, password: passwordController.text)
                .then((val){
                  if(val!.emailVerified == true){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                  }else{
                    showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("Kindly Verify Your Email"),
                        actions: [
                          Text("Okay")
                        ],
                      );
                    });
                  }
            });
          }catch(e){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));

          }
        }, child: Text("Login")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterUser()));
        }, child: Text("Register")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));
        }, child: Text("Reset Password")),
      ],),
    );
  }
}
