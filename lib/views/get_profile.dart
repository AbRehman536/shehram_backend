import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shehram_backend/views/update_profile.dart';

import '../provider/user_provider.dart';

class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),),
      body: Column(children: [
        Text("Name : ${userProvider.getUser().name.toString()}"),
        Text("Email :${userProvider.getUser().email.toString()}"),
        Text("Phone :${userProvider.getUser().phone.toString()}"),
        Text("Address :${userProvider.getUser().address.toString()}"),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
        }, child: Text("Update Profile"))

      ],),
    );
  }
}
