import 'package:flutter/material.dart';
import 'package:flutter_contact/user_service.dart';

class UserPage extends StatelessWidget {
  final User user;
  const UserPage({ Key? key, required this.user });

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text('${user.name.first} ${user.name.last}')),
        body: Center(
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Image.network(user.picture),
              const SizedBox(
                height: 30,
              ),
              Text(user.email)
            ],)
        )
    );
  }
}