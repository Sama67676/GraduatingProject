import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Others/auth_notifier.dart';
import 'Chat_screan.dart';

class StudentsListScreen extends StatelessWidget {
  const StudentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 8, 61, 104)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Material(
                      color: Colors.white,
                      elevation: 4,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('images/students (2).png'),
                                radius: 30,
                              ),
                            ),
                            const Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Students',
                                  style: TextStyle(
                                     fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 6,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                      color: const Color.fromARGB(255, 8, 61, 104),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [StudentStreamBuilder()],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudentStreamBuilder extends StatelessWidget {
  const StudentStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('position', isEqualTo: "Student")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<StudentLine> StudentWidgets = [];
            final Users = snapshot.data!.docs;
            for (var user in Users) {
              final userName = user.get('Name');
              final imageUrl = user.get('imgUrl');
              final uid = user.get('uid');

              final userWidget = StudentLine(
                  userName: userName,
                  uid: uid,
                  imageUrl: imageUrl ??
                      "https://www.google.com/imgres?imgurl=https%3A%2F%2Ficons.veryicon.com%2Fpng%2Fo%2Finternet--web%2F55-common-web-icons%2Fperson-4.png&imgrefurl=https%3A%2F%2Fwww.veryicon.com%2Ficons%2Finternet--web%2F55-common-web-icons%2Fperson-4.html&tbnid=I_U0g8AGNfXjhM&vet=12ahUKEwjvsfzR58n8AhWhXaQEHXydAgsQMygAegUIARC9AQ..i&docid=hkoQ1AXoszUhQM&w=512&h=512&q=person%20image%20icon&ved=2ahUKEwjvsfzR58n8AhWhXaQEHXydAgsQMygAegUIARC9AQ");
              StudentWidgets.add(userWidget);
            }
            return Expanded(
              child: ListView(
                children: StudentWidgets,
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

class StudentLine extends StatelessWidget {
  const StudentLine({this.userName, this.imageUrl, super.key, this.uid});
  final String? userName;
  final String? uid;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        child: Material(
          color: Colors.white,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            child: Row(children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(imageUrl!),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 180,
                  child: Text(
                    '$userName',
                    style: const TextStyle(
                       fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                      fontSize: 20, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ]),
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
                imageUrl,
                FirebaseAuth.instance.currentUser!.uid);
          }
        },
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
                authNotifier: _authNotifer,
                profilePic: profilePic,
                chatRoomId: chatRoomId,
                currentUser: currentUser,
           
              )));
}