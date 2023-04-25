import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StudentsWork extends StatelessWidget {
   StudentsWork({String? courseId, String? postId,super.key});
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
                                        StudentStreamBuilder(),
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

class StudentWorkStreamBuilder extends StatelessWidget {
   StudentWorkStreamBuilder({String? courseId, String? postId,super.key});
  String? courseId;
  String? postId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('courses')
            .doc(courseId).collection('posts')
            .doc(postId).collection('submits')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<StudentsWorkLine> TeacherWidgets = [];
            final Users = snapshot.data!.docs;
            for (var user in Users) {
              final userName = user.get('studentName');
              final imageUrl = user.get('imgUrl');
              final uid = user.get('studentId');

              final userWidget = StudentsWorkLine(
                  userName: userName,
                  uid: uid,
                  imageUrl: imageUrl ??
                      "https://www.google.com/imgres?imgurl=https%3A%2F%2Ficons.veryicon.com%2Fpng%2Fo%2Finternet--web%2F55-common-web-icons%2Fperson-4.png&imgrefurl=https%3A%2F%2Fwww.veryicon.com%2Ficons%2Finternet--web%2F55-common-web-icons%2Fperson-4.html&tbnid=I_U0g8AGNfXjhM&vet=12ahUKEwjvsfzR58n8AhWhXaQEHXydAgsQMygAegUIARC9AQ..i&docid=hkoQ1AXoszUhQM&w=512&h=512&q=person%20image%20icon&ved=2ahUKEwjvsfzR58n8AhWhXaQEHXydAgsQMygAegUIARC9AQ");
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
  const StudentsWorkLine({this.userName, this.imageUrl, super.key, this.uid});
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
             
        },
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
   }
      ),
    );
  }
}