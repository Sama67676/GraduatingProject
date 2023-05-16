import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Screan/ChatList.dart';

import '../others/groupList.dart';
final stageItems = [
   'Freshman',
    'Sophomore',
    'Junior',
    'Senior',
  ];
  String stage = 'Freshman';
  String department = 'Network dep';
final departmentitems = [
    'Computer dep',
    'Network dep',
    'Civil dep',
    'electrical  dep'
  ];
var pages=[groupsList(), Allusers()];
class UnderInstructions extends StatefulWidget {
  const UnderInstructions({super.key});

  @override
  State<UnderInstructions> createState() => _UnderInstructionsState();
}

class _UnderInstructionsState extends State<UnderInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
           Padding(
                                    padding:const EdgeInsets.symmetric(vertical:12),
                                    child: Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                             borderRadius: BorderRadius.circular(30),
                                             ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:14, vertical: 5),
                                          child:  DropdownButton<String>(
                                              isExpanded: true,
                                                borderRadius: BorderRadius.circular(35),
                                                value: department,
                                                icon: const Icon(Icons.keyboard_arrow_down),
                                                items: departmentitems.map((String item1) {
                                                  return DropdownMenuItem(

                                                    value: item1,
                                                   child: Padding(
                                                     padding: const EdgeInsets.symmetric(horizontal:8.0),
                                                     child: Text(item1, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'HP Simplified Light', color: Color.fromARGB(255, 8, 61, 104)),),
                                                   ),
                                                 );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                 setState(() {
                                                   department = newValue!;
                                                 });
                                               }),
                                          
                                        ),
                                      ),
                                    ),
                                  ),
          Padding(
                                        padding:const EdgeInsets.symmetric(vertical:12),
                                        child: Expanded(
                                          flex: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                 borderRadius: BorderRadius.circular(30),
                                                 ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:14, vertical: 5),
                                              child:  DropdownButton<String>(
                                                  isExpanded: true,
                                                    borderRadius: BorderRadius.circular(35),
                                                    value: stage,
                                                    icon: const Icon(Icons.keyboard_arrow_down),
                                                    items: stageItems.map((String item1) {
                                                      return DropdownMenuItem(

                                                        value: item1,
                                                       child: Padding(
                                                         padding: const EdgeInsets.symmetric(horizontal:8.0),
                                                         child: Text(item1, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'HP Simplified Light', color: Color.fromARGB(255, 8, 61, 104)),),
                                                       ),
                                                     );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                     setState(() {
                                                       stage = newValue!;
                                                     });
                                                   }),
                                              
                                            ),
                                          ),
                                        ),
                                      ),
        ],
      ),
      )
          
          );
       
    
  }
}


class CommentsStreamBuilder extends StatelessWidget {
   CommentsStreamBuilder({ super.key});
  String classId ='cd069b80-be8a-11ed-84dc-f16cde1aedb0';
  String postId='7xeYVeByJ7M4LVoDoRjn';
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('courses').doc(classId)
            .collection('posts').doc(postId)
            .collection('comments')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CommentsLine> CommentsWidgets = [];
            final comments = snapshot.data!.docs;
            for (var comment in comments) {
              final senderId = comment.get('senderId');
              final commentId = comment.get('commentId');
              final text = comment.get('text');
              final time = comment.get('time');

              final commentWidget = CommentsLine(
                  senderId: senderId,
                  commentId: commentId,
                  text: text,
                  time: time,
                    );
              CommentsWidgets.add(commentWidget);
            }
            return Expanded(
              child: ListView(
                children: CommentsWidgets,
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

class CommentsLine extends StatelessWidget {
  const CommentsLine({this.senderId, this.commentId, super.key, this.text, this.time});
  final String? senderId;
  final String? commentId;
  final String? text;
  final time;
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
              StreamBuilder<DocumentSnapshot>(
                          stream:FirebaseFirestore.instance.collection("users").doc(senderId).snapshots(),
                           builder: (context, snapshot) {
                            if (snapshot.data != null) {
                            return  Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             CircleAvatar(
                              radius: 30,
                             backgroundImage: NetworkImage(snapshot.data?['imgUrl']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            Column(
                              children: [
                                Text( snapshot.data?['Name'] ,
                                   style: const TextStyle(fontSize: 15, color: Colors.black45, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold)),
                               Text(
                        '$text',
                        style: const TextStyle(
                           fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                          fontSize: 20, color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                              ],
                            )      
                            ],
                            );
                          } else{
                           return  Container();
                           }
                        } 
                        )
            ]),
          ),
        ),
          onTap: () {

          
        },
      ),
    );
  }
}
