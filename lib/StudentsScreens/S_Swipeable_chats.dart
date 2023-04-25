
import 'package:flutter/material.dart';
import 'package:graduating_project_transformed/others/auth_notifier.dart';
import 'S_ChatList.dart';
import 'S_GroupList.dart';

var pages=[S_GroupsList(), S_Allusers()];
class S_SwipableChats extends StatefulWidget {
  const S_SwipableChats({super.key});


  @override
  State<S_SwipableChats> createState() => _S_SwipableChatsState();
}

class _S_SwipableChatsState extends State<S_SwipableChats> {

  @override
 void initState() {
    // print(AuthNotifier().user!.email);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: pages
        
          )
          
          );
       
    
  }
}