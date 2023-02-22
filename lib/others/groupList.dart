import '../Others/auth_notifier.dart';
import 'package:graduating_project_transformed/Screan/CreatNewGroupScreen.dart';

import '../Others/user_Entity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


import '../Screan/groupChatRoom.dart';


String uid =FirebaseAuth.instance.currentUser!.uid;
class groupList extends StatefulWidget {
  static const String ScreanRoute = 'groupList_Screen';
  groupList({super.key});

  @override
  State<groupList> createState() => _groupListState();
}

class _groupListState extends State<groupList> {
  UserModel _userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          transform: GradientRotation(0.7),
          colors: [
            Color.fromRGBO(30, 70, 120, 200),
            Color.fromRGBO(255, 255, 255, 1)
          ],
        )),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:  [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 8, left: 10, right: 10),
                child: Row(
                    children: [
                     Expanded(
                      flex: 1,
                       child: IconButton(
                              icon: const Icon(Icons.add_circle_outline,
                              size: 40,
                                  color: Color.fromARGB(255, 8, 61, 104)),
                              onPressed: () {
                                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contex) => const CreatNewGroupScreen()));
                              },
                            ),
                     ),
                        
                      Expanded(
                        flex: 1,
                        child: IconButton(onPressed: (){},
                         icon: const Icon(Icons.search,
                              size: 40,
                                  color: Color.fromARGB(255, 8, 61, 104)),),
                      )
                    ],
                  ),
              ),
              
              const groupStreamBuilder()
            ],
          ),
        ),
      ),
    );
  }
}

class groupStreamBuilder extends StatelessWidget {
  const groupStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid).collection('groups')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<userLine> userWidgets = [];
            final groups = snapshot.data!.docs;
            for (var group in groups) {
              final groupName = group.get('groupName');
              final groupId = group.get('groupId');
              final groupPic = group.get('groupImage');
    

              final userWidget = userLine(
                  groupName: groupName,
                  groupId: groupId,
                  groupPic: groupPic,
      );
              userWidgets.add(userWidget);
            }
            return Expanded(
              child: ListView(
                children: userWidgets,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class userLine extends StatelessWidget {
   userLine(
      {  this.groupName,  this.groupId,  this.groupPic, super.key, });

  final String? groupName;
  final String? groupId;
  final String? groupPic;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
      child: InkWell(
        child: Material(
          color: Colors.white,

          elevation: 1, //shadows
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
            side: BorderSide(color: Color.fromRGBO(17, 58, 99, 1), width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(groupPic!),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          groupName!,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                      
                       
                      ],
                    ),
                  
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
       AuthNotifier _authNotifer =
              Provider.of<AuthNotifier>(context, listen: false);
              callChatScreen(context, _authNotifer, groupName!, groupPic!, groupId!, uid);
            
                      },
      ),
    );
  }
}


void callChatScreen(BuildContext context, authNotifer, groupName, groupPic,
    groupId, currentUser) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (contex) => GroupChatscrean(
                groupName: groupName,
                authNotifier: authNotifer,
                groupPic: groupPic,
                groupId: groupId,
                currentUser: currentUser,
           
              )));
}





