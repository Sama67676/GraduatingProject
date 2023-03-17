import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'AddStudents.dart';
String attachmentType = 'Assignment' ;
String points = '100';
String hour = '0';
String minut = '0';
String MorEve = 'A.M.';
String day = '0';
String month= '0';
  var items = [
    'Assignment',
    'Quiz',
    'Lecture',
  
  ];
  late List<Map<String, dynamic>> memberList =[];

  bool isSelectChecked = false;
  bool isAllChecked = false;
  final TextEditingController _title=TextEditingController();
  final TextEditingController _description =TextEditingController();
  final TextEditingController _dueDate =TextEditingController();

  bool isloading = false;


class NewPostScreen extends StatefulWidget {
   NewPostScreen({ this.classId, super.key});
  String? classId;
  
  @override
  State<NewPostScreen> createState() => _NewPostScreenState(classId);
}

class _NewPostScreenState extends State<NewPostScreen> {
  String? classId;
  List <Map<String, dynamic>>? userMap=[];
  _NewPostScreenState(this.classId);
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
                            child: Expanded(flex:2, child: Text('New Post',style:TextStyle(fontSize: 25, color: Color.fromARGB(255, 8, 61, 104)))),
                          ),
                           Expanded(
                            flex: 0,
                             child: 
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal:10),
                                   child: GestureDetector(child: const Text('Done',style:TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 61, 104))),
                      onTap: (){
                        print(classId);
                     post(context, classId);
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
                                  value: attachmentType,
                                  icon: const Icon(Icons.keyboard_arrow_down,size: 30, color: Colors.black),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'HP Simplified Light', color: Colors.black,),
                                    ));
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      attachmentType = newValue!;
                                    });              
                                  }), 
                                    ),
                                  ),
                                      ),
                                  
                             const Padding(
                             padding:EdgeInsets.symmetric(horizontal:18.0, vertical: 0),
                             child: Text('Title:', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),),
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
                                  child: Container(
                                    child: TextField(controller: _title,
                                    decoration: const InputDecoration(hintText: 'Add Title' ,
                                     hintStyle: TextStyle(color: Colors.black38)
                                      ),
                                      ),
                                  )
                                    ),
                                  ),
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
                                  child: MaterialButton(onPressed: (){},
                                  child: Row(
                                    children: const [
                                      Expanded(child: Text('Add Attachement', style: TextStyle(color: Colors.black26),)),
                                      Icon(Icons.add, color: Colors.black54,)
                                    ],
                                  ),)
                                    
                                    ),
                                  ),
                                      ),
                                      
                                      
                                 const Padding(
                             padding:EdgeInsets.symmetric(horizontal:18.0, vertical: 0),
                             child: Text('Description:', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),),
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
                                  child: TextField(controller: _description,
                                  decoration: const InputDecoration(hintText: 'Add description' ,
                                  hintStyle: TextStyle(color: Colors.black38)
                                    ),
                                    )
                                    ),
                                  ),
                                      ),
                                         const Padding(
                             padding:EdgeInsets.symmetric(horizontal:18.0, vertical: 0),
                             child: Text('due date:', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold ),),
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
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                          padding: const EdgeInsets.symmetric(vertical:24,),
                                          child: Center(child: Container(
                                            height: 50,
                                            width: 50,
                                            child: ListWheelScrollView.useDelegate(
                                            
                                              perspective: 0.005,
                                              onSelectedItemChanged: (value) {

                                                points= value.toString();
                                              },
                                              physics: const FixedExtentScrollPhysics(),
                                              itemExtent: 20, 
                                            childDelegate: ListWheelChildBuilderDelegate(
                                              childCount: 101,
                                              builder: (context, index){
                                                 return Container(
                                               child: Text(index.toString(), style: const TextStyle(fontSize: 20, color: Colors.white,  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),),
                                              );
                                            })),
                                          )
                                          )
                                    ),
                                    const Text('Points', style: TextStyle(color: Colors.white, fontSize: 20,  fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold),)
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
                                      value:isAllChecked  ,
                                      shape: const CircleBorder(),
                                      onChanged: (value) async{
                                        setState(() {
                                            isAllChecked = value!;
                                            isSelectChecked = false;
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
                                      value:isSelectChecked,
                                      shape: const CircleBorder(),
                                      onChanged: (value) async{
                                        setState(() {
                                            isSelectChecked = value!;
                                            isAllChecked = false;
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
void post(context, classId)async{
  late String postId;
  final dataBaseMoreEve= MorEve == '0'? 'A.M.': 'P.M.';
  Map time ={'month': month, 'day': day, 'hour': hour, 'minute': minut, 'moreve': dataBaseMoreEve};
 await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').add({
  'postDate' :FieldValue.serverTimestamp(),
  'type': attachmentType,
  'title': _title.text,
  'description': _description.text,
  'dueDate': time,
  'attachment': '',
  'attachmentType': '',
  'points': points,
  'toStudents': memberList,
   }).then((value) async {
    postId = value.id;
     await FirebaseFirestore.instance.collection('courses').doc(classId).collection('posts').doc(value.id).update(
      {
        'postId': value.id,
      }
     );
   });
   for (int i=0; i<memberList.length; i++) {
     String uid= memberList[i]['uid'];
     await FirebaseFirestore.instance.collection('users').doc(uid).collection('courses').doc(classId).collection('posts').doc(postId).set(
    ({
      'postId' :postId,
    })
   );
   }
   
   _title.clear();
   _description.clear();
   _dueDate.clear();
   isAllChecked =false;
   isSelectChecked = false;
   attachmentType = 'Assignment' ;
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


