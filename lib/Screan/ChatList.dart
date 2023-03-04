import 'package:flutter/gestures.dart';
import 'package:graduating_project_transformed/Screan/CreatNewGroupScreen.dart';

import '../Others/auth_notifier.dart';
import '../Others/user_Entity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../Screan/Chat_screan.dart';
import '../Screan/groupChatRoom.dart';


String department = 'Computer dep' ;
var items = [
    'Computer dep',
    'Network dep',
    'Civil??? dep',
    '?????? dep'
  ];
class Allusers extends StatefulWidget {
  static const String ScreanRoute = 'allUsers_Screen';
  Allusers({super.key});

  @override
  State<Allusers> createState() => _AllusersState();
}

class _AllusersState extends State<Allusers> {
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
                          flex: 4,
                           child: DropdownButton(
                            borderRadius: BorderRadius.circular(35),
                                value: department,
                                icon: const Icon(Icons.keyboard_arrow_down,size: 30, color: Color.fromARGB(255, 8, 61, 104),),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'HP Simplified Light', color: Color.fromARGB(255, 8, 61, 104)),),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    department = newValue!;
                                  });              
                                }), 
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Text('Groups', style:  TextStyle(
                   fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                              fontSize:25, color: Color.fromARGB(255, 8, 61, 104))),
              ),
           const groupStreamBuilder(),
           const Padding(
             padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
             child: Text('Chats', style:  TextStyle(
               fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                fontSize:25, color: Color.fromARGB(255, 8, 61, 104))),
           ),
              usersStreamBuilder()
            ],
          ),
        ),
      ),
    );
  }
}


class usersStreamBuilder extends StatelessWidget {
   usersStreamBuilder({super.key});
// ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
   return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
         if (snapshot.hasData) {
            List<userLine> userWidgets = [];
            final Users = snapshot.data!.docs;
            for (var user in Users) {
              List friends= user['friendsId'];
              int lengthofList= friends.length;
              for (int i=0; i<lengthofList; i++){
                String uid= friends[i]['friend'];
                if (uid== FirebaseAuth.instance.currentUser!.uid){
                   final userName = user.get('Name');
              final uid = user.get('uid');
              final profilePic = user.get('imgUrl');
              final onlineStatus = user.get('onlineStatus');
              final String chatRoomId= friends[i]['chatRoom'];
              
               final userWidget = userLine(
                  friendName: userName,
                 chatRoomId: chatRoomId,
                  frienduid: uid,
                  profilePic: profilePic,
         
                  onlineStatus: onlineStatus);
              userWidgets.add(userWidget);
                }
              }
            }
            return Expanded(
              flex: 2,
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
  const userLine(
      {this.friendName, this.chatRoomId, this.frienduid, this.profilePic,this.onlineStatus, super.key});
  final String? chatRoomId;
  final String? friendName;
  final String? frienduid;
  final String? profilePic;
  final String? onlineStatus;

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
                  backgroundImage: NetworkImage(profilePic!),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '$friendName',
                          style: const TextStyle(
                             fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                              fontSize: 20, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: onlineStatus=="online"? true: false,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  StreamBuilder<DocumentSnapshot>(
                    stream:FirebaseFirestore.instance.collection("chatRoom").doc(chatRoomId).snapshots(),
          builder: (context, snapshot) {
             if (snapshot.data != null) {
          return Align(
            alignment:  Alignment.centerLeft,
            child:Text( snapshot.data?['lastMessage'],
                    style: const TextStyle(fontSize: 14, color: Colors.black45,
                     fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold))
          );
             }else{
              return  Container();
             }
           }
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
          if (_authNotifer.user != null) {
            
            callChatScreen(
                context,
                friendName!,
                 frienduid,
                 _authNotifer,
                  profilePic,
                  chatRoomId,
                FirebaseAuth.instance.currentUser!.uid);
          }
        },
      ),
    );
  }
}

void callChatScreen(BuildContext context, Name, frienduid, _authNotifer, profilePic,
    chatRoomId, currentUser) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (contex) => Cahtscrean(
                friendName: Name,
                frienduid: frienduid,
                authNotifier: _authNotifer,
                profilePic: profilePic,
                chatRoomId: chatRoomId,
                currentUser: currentUser,
           
              )));
}



class groupStreamBuilder extends StatelessWidget {
  const groupStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid).collection('groups')
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
              flex: 1,
              child: ListView(
                shrinkWrap: true,
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
                             fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
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
              callGroupChatScreen(context, _authNotifer, groupName!, groupPic!, groupId!, FirebaseAuth.instance.currentUser!.uid);
            
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





