import 'package:flutter/material.dart';
import 'package:shehram_backend/services/auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        ElevatedButton(onPressed: ()async{
          try{
            await AuthServices().resetPassword(
              emailController.text
            ).then((value){
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Link Send Successfully"),
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
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Send link"))
      ],),
    );
  }
}
