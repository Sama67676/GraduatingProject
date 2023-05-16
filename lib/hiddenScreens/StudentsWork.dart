import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import 'SingleStudentSubmit.dart';

class StudentsWork extends StatelessWidget {
   StudentsWork({super.key, this.courseId, this.postId});
 String? courseId;
  String? postId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
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
        child: SafeArea(child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                    
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: IconButton(
                                      icon: const Icon(Icons.arrow_back_ios,
                                          size: 30,
                                          color: Color.fromARGB(255, 8, 61, 104)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                      ),
                             
                      ],),
                    ),
                   Expanded(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal:24),
                       child: Text('Students submits:',
                         style: TextStyle(fontSize: 34,
                          fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,color:const Color.fromARGB(255, 8, 61, 104)),),
                       
                     ),
                   ),
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:18, vertical: 10),
                        child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                                color: const Color.fromARGB(255, 8, 61, 104),
                                child:Padding(
                                  padding: const EdgeInsets.symmetric(vertical:18,horizontal: 5),
                                  child: Column(
                                      children: [
                                      StudentWorkStreamBuilder(courseId: courseId, postId: postId,),
                            
                                        ],
                                    )
        ),
      )
    ),
    
                    ),
              ]
        )
        )
      )
    );
  }
}

// ignore: must_be_immutable
class StudentWorkStreamBuilder extends StatelessWidget {
   const StudentWorkStreamBuilder({this.courseId, this.postId});
  final String? courseId;
  final String? postId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('courses')
            .doc(courseId).collection('posts')
            .doc(postId!).collection('submits')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<StudentsWorkLine> TeacherWidgets = [];
            final Users = snapshot.data!.docs;
            for (var user in Users) {
              final uid = user.get('studentId');
              final time = user.get('time');
              final submitId = user.get('submitId');
              final isMarked = user.get('isMarked');

final DateTime convtime= DateTime.parse(time!.toDate().toString());
String outputTime = DateFormat('MMM d, h:mm a').format(convtime);

              final userWidget = StudentsWorkLine(
                  uid: uid,
                  time: outputTime,
                    courseId: courseId,
                    postId: postId,
                    submitId: submitId,
                    isMarked:isMarked,
                      );
             
              TeacherWidgets.add(userWidget);
            }
            return Expanded(
              child: ListView(
                children: TeacherWidgets,
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

class StudentsWorkLine extends StatelessWidget {
  const StudentsWorkLine({this.uid, this.time, this.courseId, this.postId, this.submitId, this.isMarked});
  final String? uid;
  final String? time;
  final String? courseId;
  final String? postId;
  final String? submitId;
  final String? isMarked;
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
              Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            child: Row(children: [
              StreamBuilder<DocumentSnapshot>(
                            stream:FirebaseFirestore.instance.collection("users").doc(uid).snapshots(),
                             builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                  return  Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                   Padding(
                                     padding: const EdgeInsets.only(top:8.0, bottom: 8, right: 8, left: 3),
                                     child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.white,
                                     backgroundImage: NetworkImage(snapshot.data?['imgUrl']),
                                      ),
                                   ),
                                  Container(
                                     constraints: const BoxConstraints(
                                     maxWidth: 140,
                                  ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0, right: 8, bottom: 8),
                                      child: Text( '${snapshot.data?['Name']}' ,
                                         style: const TextStyle(color: const Color.fromARGB(255, 8, 61, 104),
                                                fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                fontSize: 22,)),
                                    ),
                                  ),
                                      Padding(
                                          padding:const EdgeInsets.symmetric( horizontal: 14),
                                          child:
                                          Container(
                                             constraints: const BoxConstraints(
                                             maxWidth: 80,
                                          ),             
                                              child: Text(time!, style: const TextStyle(
                                             fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                            fontSize: 14, color: Colors.white54),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,),
                                          ),
                                                                  
                                    ),
                                  ],
                                  );
                            } else{
                             return  Container();
                             }
                          } 
                          ),
              isMarked =='true'?
              Expanded(child: Icon(Icons.done, color: Colors.green,size: 30,)):
              Container(height: 1, width: 1,),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.only(left:0, right: 8),
                   child: Text(time!, 
                   style: const TextStyle(
                       fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                        fontSize: 14, color: Colors.black45),),
                 ),
               ),
            ]),
          ),
        ),
          onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) =>SingleStudentSubmit(
              courseId:courseId , postId: postId,
              userId: uid, time: time, submitId:submitId, isMarked: isMarked,
              )
             
             ));
        },
      ),
    );
  }
}

