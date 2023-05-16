import '../Others/auth_notifier.dart';
import 'package:graduating_project_transformed/Screan/CreatNewGroupScreen.dart';

import '../Others/user_Entity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


import '../Screan/groupChatRoom.dart';
import '../hiddenScreens/SearchChat.dart';


String department = 'Computer dep' ;
var items = [
    'Computer dep',
    'Network dep',
    'Civil dep',
    'electrical  dep'
  ];
String uid =FirebaseAuth.instance.currentUser!.uid;
class groupsList extends StatefulWidget {
  static const String ScreanRoute = 'groupList_Screen';
  groupsList({super.key});

  @override
  State<groupsList> createState() => _groupsListState();
}

class _groupsListState extends State<groupsList> {
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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8, left: 10, right: 10),
                    child: Row(
                        children: [
                        
                             Expanded(
                              flex: 4,
                               child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal:18.0),
                                 child: DropdownButton(
                                  borderRadius: BorderRadius.circular(35),
                                      value: department,
                                      icon: const Icon(Icons.keyboard_arrow_down,size: 30, color: Color.fromARGB(255, 8, 61, 104),),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'HP Simplified Light', color: Color.fromARGB(255, 8, 61, 104)),),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          department = newValue!;
                                        });              
                                      }),
                               ), 
                             ),
                          Expanded(
                            flex: 1,
                            child: IconButton(onPressed: (){
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) =>  const SearchChats(title: 'Search through chats',)));
                            },
                             icon: const Icon(Icons.search,
                                  size: 40,
                                      color: Color.fromARGB(255, 8, 61, 104)),),
                          )
                        ],
                      ),
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                     Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text('Groups', style:  TextStyle(
                       fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                  fontSize:25, color: Color.fromARGB(255, 8, 61, 104))),
                  ),
                  ],),
                 const SizedBox(height: 10,),
                  const groupStreamBuilder()
                ],
              ),
               Positioned(
                left: 295,
                           
                 bottom:45,
                 child: InkWell(
                   child: Container(
                       width: 75,
                        height: 50,
                       child: Material(
                        elevation: 4,
                        
                        borderRadius: const BorderRadius.all(
                         Radius.circular(35),
                         ),
                        color:  const Color(0xFFCCCED3),
                        child: const Icon(Icons.add,  color: Color.fromARGB(255, 8, 61, 104)),
                       ),
                      ),
                      onTap: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (contex) => const CreatNewGroupScreen()));

                      },
                 ),
               ),
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
            List<groupLine> userWidgets = [];
            final groups = snapshot.data!.docs;
            for (var group in groups) {
              final groupName = group.get('groupName');
              final groupId = group.get('groupId');
              final groupPic = group.get('groupImage');
    

              final userWidget = groupLine(
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

class groupLine extends StatelessWidget {
   groupLine(
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
              callGroupChatScreen(context, _authNotifer, groupName!, groupPic!, groupId!, uid);
            
                      },
      ),
    );
  }
}


void callGroupChatScreen(BuildContext context, authNotifer, groupName, groupPic,
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





