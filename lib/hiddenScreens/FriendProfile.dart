// ignore_for_file: sort_child_properties_last


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:graduating_project_transformed/hiddenScreens/createClass.dart';

import 'package:provider/provider.dart';

import '../Others/auth_notifier.dart';
import '../Screan/Chat_screan.dart';
import '../main.dart';




 FirebaseFirestore _firestore = FirebaseFirestore.instance;
   FirebaseAuth _auth = FirebaseAuth.instance;
class FriendProfile extends StatefulWidget {
  const FriendProfile({super.key,  required this.friendId,});

  final String friendId;

  @override
  State<FriendProfile> createState() => _FriendProfileState(this.friendId);
}

class _FriendProfileState extends State<FriendProfile> {

  final String friendId;
  String? friendName;
  String? friendImage;
  String? friendstatus;
  String? department;
  String? year;
  String? chatRoomId; //هاي صفنيلها بعدين
   _FriendProfileState( this.friendId);

  Future getFriendDetails() async {
    await _firestore
        .collection('users')
        .doc(friendId)
        .get()
        .then((chatMap) {
      friendName = chatMap['Name'];
      friendImage =chatMap['imgUrl'];
      friendstatus = chatMap['status'];
      department = chatMap['department'];
      year = chatMap['year'];
      setState(() {
        
      });
   
    });
  }


  
  @override
  void initState() {
    super.initState();
    getFriendDetails();
  }

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
            Color.fromARGB(58, 1, 27, 99),
            Color.fromRGBO(255, 255, 255, 1)
          ],
        )),
        child: SafeArea(
            child: Padding(
          padding:
              const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                  Expanded(
                    flex: 2,
                    child:
                        MaterialButton(
                          child: Row(children: const [
                            Icon( Icons.arrow_back_ios,
                                    color: Color.fromARGB(255, 8, 61, 104)),
                            Text('Back', style: TextStyle(fontSize: 20, color:Color.fromARGB(255, 8, 61, 104), fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),)
                          ],),
                          onPressed: (){
                               Navigator.pop(context);
                          })
                       
                            
                      
                  ),

                  ],
                ),
       
             Padding(
               padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 5),
               child: Column(
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage:friendImage != null?
                      NetworkImage(friendImage!): null),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(friendName!, style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 8, 61, 104)),),
                      ),
                    Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            '$department $year year',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                               fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                fontSize: 30, color: Colors.indigo[900]),
                          ),
                        ),
                ],
               ),
             ),
            Expanded(
              child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                          color: const Color.fromARGB(255, 8, 61, 104),
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Expanded(
                                  child: Material(
                                        color:Colors.white,
                                          
                                          shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                        ),),
                                        child: MaterialButton(
                                          minWidth: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                                            child: Column(children: const [
                                              Icon(Icons.message_outlined,
                                                  color: Color.fromARGB(255, 8, 61, 104),
                                                  size: 40,),
                                                  Text('Message', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                  fontSize: 16,),)
                                            ],),
                                          ),
                                          onPressed: (){
                                            AuthNotifier _authNotifer =
                                                  Provider.of<AuthNotifier>(context, listen: false);
                                             if (_authNotifer.user != null) {
                                                final String? currentUserName =
                                                    _authNotifer.userDetails!.displayName;
                                               generateChatRoomId(
                                                    context,
                                                    currentUserName!,
                                                    friendName!,
                                                    friendId,
                                                    _authNotifer,
                                                    friendImage,
                                                    FirebaseAuth.instance.currentUser!.uid);
                                             }
                                        }
                                        ),
                                      ),
                                ),
                              ),
                                
                              Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Expanded(
                                  child: Material(
                                          color:Colors.white,
                                            
                                          shape: const RoundedRectangleBorder(
                                         borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                          ),), 
                                          child: MaterialButton(
                                             minWidth: 20,
                                             
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                                              child: Column(children: const [
                                                Icon(Icons.call,
                                                    color: Color.fromARGB(255, 8, 61, 104),
                                                    size: 40,),
                                                    Text('Call', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                    fontSize: 16,),)
                                              ],),
                                            ),
                                            onPressed: (){
                                        
                                          }
                                          ),
                                        ),
                                  
                                ),
                              ),
                               Padding(
                                 padding: const EdgeInsets.only(right:8.0),
                                 child: Expanded(
                                   child: Material(
                                        color:Colors.white,
                                          
                                       shape: const RoundedRectangleBorder(
                                       borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                        ),),
                                        child: MaterialButton(
                                           minWidth: 35,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                                            child: Column(children: const [
                                              Icon(Icons.notifications_outlined,
                                                  color: Color.fromARGB(255, 8, 61, 104),
                                                  size: 40,),
                                                  Text('Mute', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                  fontSize: 16,),)
                                            ],),
                                          ),
                                          onPressed: (){
                                      
                                        }
                                        ),
                                      ),
                                 ),
                               ),
                                Expanded(
                                  child: Padding(
                                   padding:  const EdgeInsets.only(right:8),
                                   child: Material(
                                    color:Colors.white,
                                    shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                        ),),
                                        child: PopupMenuButton(
                                         itemBuilder: (context) => [ const PopupMenuItem(
                                             child: Text('Delete Chatroom', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104), fontSize: 20),), value: '1'),
                                              
                                           ],
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                                            child: Column(children: const [
                                              Icon(Icons.more_vert,
                                                  color: Color.fromARGB(255, 8, 61, 104),
                                                  size: 40,),
                                                  Text('More', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                  fontSize: 16,),)
                                            ],),
                                          ),
                                         onSelected: (result) {
                                             if (result == '1'){
                                     AlertDeletingChatRoom(context, chatRoomId, friendId, FirebaseAuth.instance.currentUser!.uid);
                                                 }
                                            },
                                        ),
                                      ),
                                                               ),
                                ),
                              
                            ],),
                         )),
            ),
              
              Expanded(
                  flex:4,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                      color: const Color.fromARGB(255, 8, 61, 104),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                           Padding(
                             padding: const EdgeInsets.all(3),
                             child: Container(
                               width: 370,
                               height: 80,
                               child: Material(
                                 color: Colors.white,
                                 elevation: 1, //shadows
                                 shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                               ),
                                child: Column(
                             
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
                                  child: Text('bio', style: TextStyle(
                                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                            fontSize: 20, color: Colors.indigo[900])),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                  child: Text(friendstatus != null?
                                  friendstatus! : 'Say hi',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                         fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                          fontSize: 20, color: Colors.indigo[900])),
                                ),
                              ],
                                                     ),
                                                   ),
                                                 ),
                           ),
                            
                          ],
                        ),
                      )),
                ),
            ],
          ),
        )),
      ),
    );
  }
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
              Map<String, dynamic> myDetails ={'chatRoom': chatRoomId, 'friend': currentUser};
              firestore.collection('users').doc(frienduid).update({
             "friendsId": FieldValue.arrayUnion([myDetails])
           
            });
             Map<String, dynamic> friendDetails ={'chatRoom': chatRoomId, 'friend': frienduid};
            firestore.collection('users').doc(currentUser).update({
              "friendsId": FieldValue.arrayUnion([friendDetails])
            });
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

void callChatScreen(BuildContext context, Name, frienduid, _authNotifer, profilePic,
    chatRoomId, currentUser) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (contex) => Cahtscrean(
                friendName: Name,
                frienduid: frienduid,
      
                profilePic: profilePic,
                chatRoomId: chatRoomId,
                currentUser: currentUser,
           
              )));
}


Future<void> AlertDeletingChatRoom(context,chatRoomId, friendId, currentUser) async{
       return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(30),
        actionsPadding: const EdgeInsets.only(left:20, right: 20, bottom: 20),
       shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35))),
       
        content:const Text('Are you sure you want to delete this Chat?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
             
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              onDeleteGroup(chatRoomId, context, friendId, currentUser);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }

   Future onDeleteGroup(String chatRoomId,context, friendId, currentId)async{
    await FirebaseFirestore.instance.collection('chatRoom').doc(chatRoomId).delete();
    print('ChatRoom deleted');
  
    await FirebaseFirestore.instance.collection('users').doc(friendId);
    Navigator.pop(context);
  }