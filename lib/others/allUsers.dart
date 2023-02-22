import 'package:graduating_project_transformed/Screan/CreatNewGroupScreen.dart';

import '../Others/user_Entity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../Screan/Chat_screan.dart';
import 'auth_notifier.dart';

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
                                    child: Text(items, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 8, 61, 104)),),
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
              
              const usersStreamBuilder()
            ],
          ),
        ),
      ),
    );
  }
}

class usersStreamBuilder extends StatelessWidget {
  const usersStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<userLine> userWidgets = [];
            final Users = snapshot.data!.docs;
            for (var user in Users) {
              final userName = user.get('Name');
              final status = user.get('status');
              final uid = user.get('uid');
              final profilePic = user.get('imgUrl');
              final onlineStatus = user.get('onlineStatus');

              final userWidget = userLine(
                  userName: userName,
                  status: status,
                  uid: uid,
                  profilePic: profilePic,
                  onlineStatus: onlineStatus);
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
  const userLine(
      {this.userName, this.status, this.uid, this.profilePic,this.onlineStatus, super.key});
  final String? status;
  final String? userName;
  final String? uid;
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
                          '$userName',
                          style: const TextStyle(
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
                    Text(
                      '$status',
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black45),
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
            final String? currentUserName =
                _authNotifer.userDetails!.displayName;
            generateChatRoomId(
                context,
                currentUserName!,
                userName!,
                uid,
                _authNotifer,
                profilePic,
                FirebaseAuth.instance.currentUser!.uid);
          }
        },
      ),
    );
  }
}

void callChatScreen(BuildContext context, Name, uid, _authNotifer, profilePic,
    chatRoomId, currentUser) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (contex) => Cahtscrean(
                friendName: Name,
                frienduid: uid,
                authNotifier: _authNotifer,
                profilePic: profilePic,
                chatRoomId: chatRoomId,
                currentUser: currentUser,
           
              )));
}

void generateChatRoomId(BuildContext context, String currentUserName,
    String friendName, frienduid, _authNotifer, profilePic, currentUser) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
  String chatRoomId= getChatRoomId(currentUserName, friendName);
  List<String?> chatUsers = [friendName, currentUserName];
  List<dynamic> usersId = [frienduid,currentUser];
  Map<String, dynamic> chatRoomMap = {'chatRoomId':chatRoomId,'users': chatUsers, 'uids': usersId};

DocumentSnapshot chatRoomExisting= await firestore.collection('chatRoom').doc(chatRoomId).get();
  if (chatRoomExisting.exists){
   // ignore: use_build_context_synchronously
   callChatScreen(context, friendName, frienduid, _authNotifer, profilePic,
            chatRoomId, currentUser);}
            else if(!chatRoomExisting.exists){
              firestore.collection('chatRoom').doc(chatRoomId).set(chatRoomMap).then((value) => callChatScreen(context, friendName, frienduid, _authNotifer, profilePic,
            chatRoomId, currentUser));
            }
}


String getChatRoomId(String user1, String user2){
  if (user1[0].toLowerCase().codeUnits[0] > user2[0].toLowerCase().codeUnits[0]){
    return "$user1$user2";
  }else{
    return '$user2$user1';
  }
}



