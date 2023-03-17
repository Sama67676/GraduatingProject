import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';



import 'AddStudents.dart';
String department = 'Computer dep' ;
var items = [
    'Computer dep',
    'Network dep',
    'Civil??? dep',
    '?????? dep'
  ];
  late List<Map<String, dynamic>> memberList =[];

  bool isSelectChecked = false;
  bool isAllChecked = false;
  final TextEditingController _ClassName=TextEditingController();
  final TextEditingController _SubjectName=TextEditingController();
    bool isloading = false;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class CreatNewClassScreen extends StatefulWidget {
  const CreatNewClassScreen({super.key});

  @override
  State<CreatNewClassScreen> createState() => _CreatNewClassScreenState();
}

class _CreatNewClassScreenState extends State<CreatNewClassScreen> {
  List <Map<String, dynamic>>? userMap=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
          child: Column(

              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [
                
                  Expanded(
                    flex: 0,
                    child: 
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10),
                          child: GestureDetector(child: const Text('Cancel',style:TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 61, 104))),
                          onTap: (){
                            Navigator.pop(context);
                          },
                          ),
                        ),
                      
                    
                  ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal:20),
                            child: Expanded(flex:2, child: Text('Create Class',style:TextStyle(fontSize: 25, color: Color.fromARGB(255, 8, 61, 104)))),
                          ),
                           Expanded(
                            flex: 0,
                             child: 
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal:10),
                                   child: GestureDetector(child: const Text('Done',style:TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 61, 104))),
                      onTap: (){
                        creatClass(context);
                      },
                      ),
                                 ),
                               
                           ),
                  ],),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                        color: const Color.fromARGB(255, 8, 61, 104),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                                   const SizedBox(height: 20,),
                                                   const Padding(
                             padding:EdgeInsets.symmetric(horizontal:18.0, vertical: 0),
                             child: Text('Class Name:', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),),
                                                   ),
                                                  Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 15),
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
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  child: TextField(controller: _ClassName,
                                  decoration: const InputDecoration(hintText: 'Enter class name' ,
                                   hintStyle: TextStyle(color: Colors.black38)
                                    ),
                                    )
                                    ),
                                  ),
                                      ),
                                 const Padding(
                             padding:EdgeInsets.symmetric(horizontal:18.0, vertical: 0),
                             child: Text('Subject Name:', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),),
                                                   ),
                                                  Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 15),
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
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  child: TextField(controller: _SubjectName,
                                  decoration: const InputDecoration(hintText: 'Enter subject name' ,
                                  hintStyle: TextStyle(color: Colors.black38)
                                    ),
                                    )
                                    ),
                                  ),
                                      ),
                                             const Padding(
                             padding:EdgeInsets.symmetric(horizontal:18.0, vertical: 0),
                             child: Text('choose the department : ', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),),
                                                   ),
                                                  Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 15),
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
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                            child:  DropdownButton(
                              isExpanded:true,
                              borderRadius: BorderRadius.circular(35),
                                  value: department,
                                  icon: const Icon(Icons.keyboard_arrow_down,size: 30, color: Colors.black),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'HP Simplified Light', color: Colors.black,),
                                    ));
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      department = newValue!;
                                    });              
                                  }), 
                                    ),
                                  ),
                                      ),
                                               Row(
                                                 children: [
                                                   Transform.scale(
                                                   scale: 1.3,
                                              child: Checkbox(
                                              checkColor: const Color.fromARGB(255, 8, 61, 104) ,
                                              fillColor:  MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                   if (states.contains(MaterialState.disabled)) {
                            return Colors.white;
                             }
                             return Colors.white;
                                                   }),
                                              activeColor: Colors.white,
                                      value:isSelectChecked,
                                      shape: const CircleBorder(),
                                      onChanged: (value) async{
                                        setState(() {
                                            isSelectChecked = value!;
                                            isAllChecked = false;
                                        });
                                        if(value==true){
                                        await getAllStudents();
                                        } else if(value==false){
                                        memberList.clear();
                                        }
                                      },
                                      
                                    ),
                                            ),
                                            const Text('Add all  students', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),)
                                                 ],
                                               ),
                                                 Row(
                                                 children: [
                                                   Transform.scale(
                                                   scale: 1.3,
                                              child: Checkbox(
                                              checkColor: const Color.fromARGB(255, 8, 61, 104) ,
                                              fillColor:  MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                                   if (states.contains(MaterialState.disabled)) {
                            return Colors.white;
                             }
                             return Colors.white;
                                                   }),
                                              activeColor: Colors.white,
                                      value:isAllChecked,
                                      shape: const CircleBorder(),
                                      onChanged: (value) async{
                                        setState(() {
                                            isAllChecked = value!;
                                            isSelectChecked= false;
                                        });
                                        if(value==true) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                            builder: (contex) => const AddStudents())).then((value2) {
                                               print(value2);
                                               memberList= value2;
                                            },);
                                           
                                        } else if(value==false){
                                        memberList.clear();
                                        }
                                     
                                      },
                                      
                                    ),
                                            ),
                                            const Text('Select students ', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),)
                                                 ],
                                               ),
                                          ],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          
        ),
      ),
    );
  }
}

void creatClass(context)async{
  var uuid = const Uuid();
  isloading =true;
   
  
  String classId= uuid.v1();
  await firestore.collection('courses').doc(classId).set({
  'courseId':classId,
   'courseName': _ClassName.text,
   'courseSubject':_SubjectName.text, 
   'department': department,
   'teacherId':  'J9Ch8HoxoOV0IpGN8QnC2EdQdvX2' //this will change
  });
   for (int i=0; i<memberList.length; i++){
    String uid= memberList[i]['uid'];
    String name = memberList[i]['name'];
     await firestore.collection('courses').doc(classId).collection('students').add({
      'studentName': name,
      'studentId': uid,
         
   });
  }
  for (int i=0; i<memberList.length; i++){
    String uid= memberList[i]['uid'];
    await firestore.collection('users').doc(uid).collection('courses').doc(classId).set({
     'courseName': _ClassName.text,
      'courseId':classId,
      'courseSubject':_SubjectName.text, 
      'teacherId': 'J9Ch8HoxoOV0IpGN8QnC2EdQdvX2' 
    });
  }
  _ClassName.clear();
  _SubjectName.clear();
  isSelectChecked = false;
  isAllChecked =false;
  memberList.clear();
  Navigator.pop(context);

}


  Future getAllStudents() async {
    await FirebaseFirestore.instance
        .collection('users').where('position', isEqualTo: 'Student')
         .get().then((QuerySnapshot querySnapshot){
            for (var element in querySnapshot.docs) {
         memberList.add({'name':element['Name'], 'uid': element['uid']});
            }
         });
         print(memberList);
  }
