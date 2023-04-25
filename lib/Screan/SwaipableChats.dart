
import 'package:flutter/material.dart';

import '../Others/auth_notifier.dart';
import '../others/groupList.dart';
import 'ChatList.dart';

var pages=[groupsList(), Allusers()];
class SwipableChats extends StatefulWidget {
  const SwipableChats({super.key});

  @override
  State<SwipableChats> createState() => _SwipableChatsState();
}

class _SwipableChatsState extends State<SwipableChats> {
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