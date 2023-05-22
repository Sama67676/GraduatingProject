// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Others/Prefrences.dart';
import '../Screan/Chat_screan.dart';
String name ='loading';
String reName='loading';



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

     void getprefrences(){
     UserPrefrences().getUserName().then((value){
    setState(() {
           name= value.toString();
             print(name.toString());
              reName= name.substring( 1, name.length - 1 );
    });
    }
    );
   
}

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
     getprefrences();
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    MaterialButton(
                          child: const Icon( Icons.arrow_back_ios,
                                    color: Color.fromARGB(255, 8, 61, 104),
                                    size: 30,),
                          onPressed: (){
                               Navigator.pop(context);
                          }),
                          Stack(children: [
               Column(
                 children: [
                   Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 170,
                  width: 400,
                  child: const Material(
                     color: Colors.white,
                        elevation: 1, //shadows
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(35),
                          ),
                        ),
                  ),
                ),
              ),
                  SizedBox(height: 70,),
                 ],
               ),
             
              Positioned(
                top: 110,
                left: 130,
                child: Column(
                      children: [
                        CircleAvatar(
                            radius: 50,
                            backgroundImage:friendImage != null?
                            NetworkImage(friendImage!): null),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(friendName!, style: const TextStyle(fontSize: 26, color: Color.fromARGB(255, 8, 61, 104)),),
                            ),
                      ],
                     ),
              ),
            ]
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
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal:16, vertical: 12),
                              child: Text('Info',
                              style: TextStyle(fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                              color:  Colors.white, fontSize: 20
                              ),),
                            ),
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
                                child:
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  child: Text('$year $department engineering department', style: TextStyle(
                                           fontFamily: 'HP Simplified Light', 
                                            fontSize: 20, color: Colors.indigo[900])),
                                ),
                                                   ),
                                                 ),
                           ),
                             const Padding(
                              padding: EdgeInsets.symmetric(horizontal:16, vertical: 12),
                              child: Text('bio',
                              style: TextStyle(fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                              color:  Colors.white, fontSize: 20
                              ),),
                            ),
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
                                child:
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  child: Text(friendstatus != ''?friendstatus!: 'Say hi', style: TextStyle(
                                           fontFamily: 'HP Simplified Light', 
                                            fontSize: 20, color: Colors.indigo[900])),
                                ),
                                                   ),
                                                 ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(18),
                             child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                                   width: 140,
                                                   height: 60,
                                                   child: Material(
                                                     color: Colors.white,
                                                     borderRadius: BorderRadius.circular(45),
                                                     child: MaterialButton(
                                  child: Row(
                                    children: const [
                                       Padding(
                                        padding:  EdgeInsets.all(8),
                                        child:  Text(
                                          'Message',
                                          style: TextStyle(
                                             fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                              color:  Color.fromARGB(255, 8, 61, 104)
,
                                              fontSize: 18),
                                        ),
                                      ),
                                     Icon(Icons.message_outlined,
                                   color:  Color.fromARGB(255, 8, 61, 104),
                                   size: 22,),
                                    ],
                                  ),
                                   onPressed: ()async {
                                 generateChatRoomId(context,reName, friendName!,friendId,friendImage,_auth.currentUser!.uid);
                                    
                                  },
                                                     ),
                                                   ),
                                                 ),
                               ],
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
    String friendName, frienduid, profilePic, currentUser) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
  String chatRoomId= getChatRoomId(currentUserName, friendName);
  List<String?> chatUsers = [friendName, currentUserName];
  List<dynamic> usersId = [frienduid,currentUser];
  Map<String, dynamic> chatRoomMap = {'chatRoomId':chatRoomId,'users': chatUsers, 'uids': usersId};

DocumentSnapshot chatRoomExisting= await firestore.collection('chatRoom').doc(chatRoomId).get();
  if (chatRoomExisting.exists){
   // ignore: use_build_context_synchronously
   callChatScreen(context, friendName, frienduid, profilePic,
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
              firestore.collection('chatRoom').doc(chatRoomId).set(chatRoomMap).then((value) => callChatScreen(context, friendName, frienduid, profilePic,
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

void callChatScreen(BuildContext context, Name, frienduid, profilePic,
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