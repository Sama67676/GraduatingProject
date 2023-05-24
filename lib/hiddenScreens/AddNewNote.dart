import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduating_project_transformed/others/auth_notifier.dart';
import 'package:provider/provider.dart';

import 'AddStudents.dart';
 bool isloading = false;
 bool isDone= false;
String NoteType = 'Assignment' ;
  var items = [
    'Assignment',
    'Quiz',
    'Lecture',
    'midTerm'
  ];
late List<Map<String, dynamic>> memberList =[];
bool isSelectChecked = false;
bool isAllChecked = false;
bool isMeChecked = false;
bool me= false;
String hour = '0';
String minut = '0';
String MorEve = 'A.M.';
String day = '0';
String month= '0';
String? noteId;
TextEditingController _title = TextEditingController();
TextEditingController _note = TextEditingController();
// ignore: camel_case_types
class Addevent extends StatefulWidget {
  const Addevent({super.key});

  @override
  State<Addevent> createState() => _AddeventState();
}

class _AddeventState extends State<Addevent> {
    void createNote(context)async{
      setState(() {
        isloading= true;
      });
     final dataBaseMoreEve= MorEve == '0'? 'A.M.': 'P.M.';
  Map time ={'month': month, 'day': day, 'hour': hour, 'minute': minut, 'moreve': dataBaseMoreEve};

  await FirebaseFirestore.instance
        .collection('Notes').add({
          'creator': FirebaseAuth.instance.currentUser!.uid,
          'note': _note.text,
          'noteType': '',
          'title': _title.text,
          'to': memberList,
          'toTime': time,
        }).then((value)async {
           noteId= value.id;
          await FirebaseFirestore.instance
        .collection('Notes').doc(value.id).update({
          'noteId' : value.id,
          
        });
   for (int i=0; i<memberList.length; i++){
    String uid= memberList[i]['uid'];
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('Notes').doc(noteId).set({
      'noteId':noteId,
      'noteType': NoteType,
      'title': _title.text,
      'creator': FirebaseAuth.instance.currentUser!.uid,
       'toTime': time,
    });
  }
        });
 setState(() {
  isloading= false;
  isDone= true;
  });

  _title.clear();
  _note.clear();
  memberList.clear();
   Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Stack(
                  children: [
                    Column(children: [
                      const SizedBox(height: 10,),
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
                                  _note.clear();
                                  _title.clear();
                                   isSelectChecked = false;
                                   isAllChecked = false;
                                   isMeChecked = false;
                                  Navigator.pop(context);
                                },
                                ),
                              ),
                            
                          
                        ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal:20),
                                  child: Expanded(flex:2, child: Text('New Note',style:TextStyle(fontSize: 25, color: Color.fromARGB(255, 8, 61, 104)))),
                                ),
                                 Expanded(
                                  flex: 0,
                                   child: 
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal:10),
                                         child: GestureDetector(child: const Text('Done',style:TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 61, 104))),
                            onTap: (){
                             createNote(context);
                            },
                            ),
                                       ),
                                     
                                 ),
                        ],),
                      ),
              const SizedBox(height: 10,),
                    Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:18, vertical: 15),
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
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: const [
                                              Text('Month', style: TextStyle(fontSize: 20, color: Colors.black26, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                           
                                               Text('Day', style: TextStyle(fontSize: 20, color: Colors.black26, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                        
                                               Text('hour', style: TextStyle(fontSize: 20, color: Colors.black26, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                            
                                                 Text('Minute', style: TextStyle(fontSize: 20, color: Colors.black26, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                            SizedBox(width: 35,),
                                            ],),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                  height: 80,
                                                  width:30,
                                                  child: ListWheelScrollView.useDelegate(
                                                        perspective: 0.005,
                                                
                                                        onSelectedItemChanged: (value) {
                                                          setState(() {
                                                                 month= value.toString();
                                                          });
                                                     
                                                        },
                                                        physics: const FixedExtentScrollPhysics(),
                                                        itemExtent: 20, 
                                                      childDelegate: ListWheelChildBuilderDelegate(
                                                        childCount: 12,
                                                        builder: (context, index){
                                                          return Container(
                                                          child: Text(index.toString(), style:  TextStyle(fontSize: 20,  color:month == index.toString()?Colors.black:Colors.black26,   fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                                           );
                                                      })),),
                                      
                                                  Container(
                                                  height: 80,
                                                  width:30,
                                                  child: ListWheelScrollView.useDelegate(
                                                        perspective: 0.005,
                                                        onSelectedItemChanged: (value) {
                                                          setState(() {
                                                              day= value.toString();
                                                          });
                                                        
                                                        },
                                                        physics: const FixedExtentScrollPhysics(),
                                                        itemExtent: 20, 
                                                      childDelegate: ListWheelChildBuilderDelegate(
                                                        childCount: 32,
                                                        builder: (context, index){
                                                        return Container(
                                                        child: Text(index.toString(), style:  TextStyle(fontSize: 20,  color:day == index.toString()?Colors.black:Colors.black26,   fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                                      );
                                                      })),),
                                           
                                                Container(
                                                  height: 80,
                                                  width:30,
                                                  child: ListWheelScrollView.useDelegate(
                                                        perspective: 0.005,
                                                        onSelectedItemChanged: (value) {
                                                          setState(() {
                                                              hour= value.toString();
                                                          });
                                                        
                                                        },
                                                        physics: const FixedExtentScrollPhysics(),
                                                        itemExtent: 20, 
                                                      childDelegate: ListWheelChildBuilderDelegate(
                                                        childCount: 13,
                                                        builder: (context, index){
                                                          return Container(
                                                       child: Text(index.toString(), style:  TextStyle(fontSize: 20, color:hour == index.toString()?Colors.black:Colors.black26,  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                                     );
                                                      })),),
                                                      
                                                      
                                    
                                                      Container(
                                                  height: 80,
                                                  width:30,
                                                  child: ListWheelScrollView.useDelegate(
                                                    
                                                        perspective: 0.005,
                                                        onSelectedItemChanged: (value) {
                                                          setState(() {
                                                            minut= value.toString();
                                                          });
                                                          
                                                        },
                                                        physics: const FixedExtentScrollPhysics(),
                                                        itemExtent: 20, 
                                                      childDelegate: ListWheelChildBuilderDelegate(
                                                        childCount: 60,
                                                        builder: (context, index){
                                                         return Container(
                                                    child: Text(index<10? '0' + index.toString():
                                                     index.toString(), style:  TextStyle(fontSize: 20, color:minut == index.toString()?Colors.black:Colors.black26,  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                                  );
                                                      })),),
                                                
                                                      
                                                      Container(
                                                  height: 80,
                                                  width:30,
                                                  child: ListWheelScrollView.useDelegate(
                                                        perspective: 0.005,
                                                        onSelectedItemChanged: (value) {
                                                          setState(() {
                                                              MorEve= value.toString();
                                                          });
                                                        
                                                        },
                                                        physics: const FixedExtentScrollPhysics(),
                                                        itemExtent: 20, 
                                                      childDelegate: ListWheelChildBuilderDelegate(
                                                        childCount: 2,
                                                        builder: (context, index){
                                                         if(index ==1){
                                                          return Container(
                                                    child: Text('P.M.',
                                                     style:  TextStyle(fontSize: 20,  color:MorEve == index.toString()?Colors.black:Colors.black26,  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                                      );
                                                          
                                                         }else{
                                                         return Container(
                                                    child: Text( 'A.M.',
                                                    style:  TextStyle(fontSize: 20, color:MorEve == index.toString()?Colors.black:Colors.black26,  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                                  );
                                                         }
                                                      })),)
                                              ],),
                                          ],
                                        ),
                                        )
                                          ),
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
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical:18),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                            
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0,),
                                                child: Text(
                                                  'Title:',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white54,
                                                      fontFamily: 'HP Simplified Light',
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 8.0, vertical: 15),
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
                                                            horizontal: 10,
                                                            vertical: 2,
                                                            ),
                                                          child: Container(
                                                            height: 60,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(6),
                                                              child: TextField(
                                                                controller: _title,
                                                                  decoration: const InputDecoration(
                                                                      border:
                                                                          InputBorder.none,
                                                                      hintText: 'Enter Title',
                                                                      hintStyle: TextStyle(
                                                                          color: Colors
                                                                              .black38)),
                                                        
                                                           ),

                                                            ),
                                                          )))),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 12.0,right:12, top: 10),
                                                child: Text(
                                                  'Note:',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white54,
                                                      fontFamily: 'HP Simplified Light',
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 15),
                                                child: Container(
                                                  height: 150,
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
                                                          horizontal: 10,
                                                          vertical: 12,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(6),
                                                          child: TextField(
                                                            controller: _note,
                                                            decoration: const InputDecoration(
                                                                border: InputBorder.none,
                                                                hintText:
                                                                    'Write your important note',
                                                                hintStyle: TextStyle(
                                                                    color: Colors.black38)),
                                                            
                                                          ),
                                                        )
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                      horizontal: 8.0, vertical: 15),
                                                child: Container(
                                                  height: 60,
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
                                                       horizontal: 12,
                                                       vertical: 16,
                                                      ),
                                                      child:  DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          isExpanded:true,
                                                         borderRadius: BorderRadius.circular(35),
                                                        value: NoteType,
                                                      icon:const Icon(Icons.keyboard_arrow_down,size: 35,color:  Color.fromARGB(255, 8, 61, 104),),
                                                        items: items.map((String items) {
                                                          return DropdownMenuItem(
                                                           value: items,
                                                           child: Text(items, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'HP Simplified Light', color: Color.fromARGB(255, 8, 61, 104),),
                                                          ));
                                                        }).toList(),
                                                         onChanged: (String? newValue) {
                                                         setState(() {
                                                           NoteType = newValue!;
                                                         });              
                                                        }),
                                                      ), 
                                                       ),
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
                                                isMeChecked= false;
                                            });
                                            if(value==true){
                                            await getAllStudents();
                                            } else if(value==false){
                                            memberList.clear();
                                            }
                                          },
                                          
                                        ),
                                                ),
                                                const Text('Add all students', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),)
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
                                                 isMeChecked= false;
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
                                          value:isMeChecked,
                                          shape: const CircleBorder(),
                                          onChanged: (value) async{
                                            setState(() {
                                                isSelectChecked = false;
                                                isAllChecked = false;
                                                isMeChecked= value!;
                                            });
                                            if(value==true){
                                              memberList.clear();
                                              getOnlyMe();
                                            } 
                                          },
                                          
                                        ),
                                                ),
                                                const Text('Me only', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),)
                                                     ],
                                                   ),
                                            ]
                                            ),
                                          )
                                          )
                                          )
                                          )
                                          )
                                          )
                    ]
                    ),
                      isloading ? const Center(
             child: SizedBox(
                  height: 60,
                  width: 60,
                          child:  CircularProgressIndicator(
                          color: Colors.black38,
                           strokeWidth: 4,
                          ),
                        ),
         
             
           ) : isDone? 
           Center(
             child: Container(
              height: 80,
              width: 80,
                      child:  showDone()
                    ),
           ):
           
           Container(height: 1, width: 1,)
                  ],
                ),
              ),
            )
            )
            );
  }
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
  
  Future getOnlyMe() async {
    await FirebaseFirestore.instance
        .collection('users').where('position', isEqualTo: 'Student')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
         .get().then((QuerySnapshot querySnapshot){
            for (var element in querySnapshot.docs) {
         memberList.add({'name':element['Name'], 'uid': element['uid']});
            }
         });
         print(memberList);
  }
Widget showDone(){
return Container(
  decoration: const BoxDecoration(shape: BoxShape.circle,
  color: Colors.green),
child: const Icon(Icons.done, size: 60 , color: Colors.white,)
);
}