import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../hiddenScreens/createClass.dart';
String uid =FirebaseAuth.instance.currentUser!.uid;
class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: Container(
        width: 75,
                  height: 50,
         child: FloatingActionButton(
          child: const Icon(Icons.add,  color: Color.fromARGB(255, 8, 61, 104)),
             backgroundColor:  const Color(0xFFCCCED3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contex) => const CreatNewClassScreen()));
          },
         ),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
              const EdgeInsets.only(left: 25, right: 15, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SizedBox(
                height: 65,
              ),
            calssStreamBuilder(),
             
            ],
          ),
        )),
      ),
    );
  }
}


class calssStreamBuilder extends StatelessWidget {
  const calssStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid).collection('courses')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<classLine> classWidgets = [];
            final classes = snapshot.data!.docs;
            for (var oneclass in classes) {
              final className = oneclass.get('courseName');
              final classId = oneclass.get('courseId');
              final calssSubject = oneclass.get('courseSubject');
              final teacherId = oneclass.get('teacherId');
  
              final classWidget = classLine(
                  className: className,
                  classId: classId,
                  calssSubject: calssSubject,
                  teacherId:teacherId,
      );
              classWidgets.add(classWidget);
            }
            return Expanded(
              child: ListView(
                children: classWidgets,
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


class classLine extends StatelessWidget {
   classLine(
      {  this.className,  this.classId, this.calssSubject, this.teacherId, super.key, });

  final String? className;
  final String? classId;
  final String? calssSubject;
  final String? teacherId;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 6, top: 6),
      child: InkWell(
        child:  Material(
                elevation: 10,
                borderRadius: const BorderRadius.all(Radius.circular(35)),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 8, 61, 104), //New
                            blurRadius: 0,
                            offset: Offset(-10, 0)),
                      ]),
                  child: Material(
                    color: Colors.white,
                    elevation: 1, //shadows
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(className!,
                              style: TextStyle(
                                fontSize: 25,
                                 fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                color: Colors.indigo[900],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            calssSubject!,
                            style: TextStyle(
                               fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.indigo[900],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                         StreamBuilder<DocumentSnapshot>(
                          stream:firestore.collection("users").doc(teacherId).snapshots(),
                           builder: (context, snapshot) {
                            if (snapshot.data != null) {
                            return  Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                             CircleAvatar(
                              radius: 15,
                             backgroundImage: NetworkImage(snapshot.data?['imgUrl']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            Text( snapshot.data?['Name'] ,
                               style: const TextStyle(fontSize: 15, color: Colors.black45, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold))      
                            ],
                            );
                          } else{
                           return  Container();
                           }
                        } 
                        )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        onTap: () {
      
            
                      },
      ),
    );
  }
}
