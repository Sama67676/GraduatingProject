import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../Others/auth.dart';

String department = 'Computer dep';
final departmentitems = [
  
    'Computer dep',
    'Network dep',
    'Civil??? dep',
    '?????? dep'
  ];

final stageItems = [
   'Freshman',
    'Sophomore',
    'Junior',
    'Senior',
  ];
  String stage = 'Freshman';

class AddNewStudent2 extends StatefulWidget {
  const AddNewStudent2({super.key});

  @override
  State<AddNewStudent2> createState() => _AddNewStudent2State();
}

class _AddNewStudent2State extends State<AddNewStudent2> {
    String name = "";

  String email = "";

  String password = "";
bool isLoading= false;
bool isDone= false;
bool isFailed = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
        resizeToAvoidBottomInset: true,
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
          child: Stack(
            children: [
              Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                child: Expanded(flex:2, child: Text('Add student',style:TextStyle(fontSize: 25, color: Color.fromARGB(255, 8, 61, 104)))),
                              ),
                               Expanded(
                                flex: 0,
                                 child: 
                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal:10),
                                       child: GestureDetector(child: const Text('Done',style:TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 61, 104))),
                          onTap: ()async{
                          setState(() {
                                    isLoading = true;
                                    isDone = false;
                                    isFailed= false;
                                  });
                            
                              try {
                                await Authintication()
                                    .createUserAnonymous(
                                        email,
                                        password,
                                        name,
                                        department,
                                        stage,
                                      'Student')
                                    .then((value) {
                                 setState(() {
                                      isLoading = false;
                                       isDone = true;
                                    });
                                });
                              } on FirebaseException catch (e) {
                                print(e);
                                setState(() {
                                      isLoading = false;
                                      isFailed = true;
                                    });
                              }
                          }
                          ),
                                     ),
                                
                               ),
                      ],),
                    ),
                   
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10, vertical: 10),
                        child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                                color: const Color.fromARGB(255, 8, 61, 104),
                                child:Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: SingleChildScrollView(
                                    child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: screenHeight*0.78,
                                          child: ListView(
                                                                      
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    radius: 55,
                                                    child:  Container(
                                                      height: 80,
                                                      width: 80,
                                                      child: Image.asset('images/addStudent.png')),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.symmetric(horizontal:12),
                                                    child: Text('Add new student account !', style: TextStyle(color: Colors.white,
                                                    fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                    fontSize: 20
                                                    ),),
                                                  )
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(vertical:14, horizontal: 10),
                                                child: Text('Enter email here :', style: TextStyle(color: Colors.white60,
                                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                      ),),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                       borderRadius: BorderRadius.circular(30),
                                                       ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:14, vertical: 5),
                                                    child: TextField(
                                                      decoration: const InputDecoration(
                                                        hintText: 'Email',
                                                            hintStyle: TextStyle(color: Colors.black38),
                                                             border: InputBorder.none,
                                                      ),
                                                      onChanged: (value){
                                                        email = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                               const Padding(
                                                padding: EdgeInsets.symmetric(vertical:14, horizontal: 10),
                                                child: Text('Enter Password here:', style: TextStyle(color: Colors.white60,
                                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                      ),),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                       borderRadius: BorderRadius.circular(30),
                                                       ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:14, vertical: 5),
                                                    child: TextField(
                                                      decoration: const InputDecoration(
                                                        hintText: 'Password',
                                                            hintStyle: TextStyle(color: Colors.black38),
                                                             border: InputBorder.none,
                                                      ),
                                                      onChanged: (value){
                                                        password = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              
                                               const Padding(
                                                padding: EdgeInsets.symmetric(vertical:14, horizontal: 10),
                                                child: Text('Enter name here :', style: TextStyle(color: Colors.white60,
                                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                      ),),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                       borderRadius: BorderRadius.circular(30),
                                                       ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal:14, vertical: 5),
                                                    child: TextField(
                                                      
                                                      decoration: const InputDecoration(
                                                        hintText: 'Name',
                                                            hintStyle: TextStyle(color: Colors.black38),
                                                             border: InputBorder.none,
                                                      ),
                                                      onChanged: (value){
                                                        name = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                                  const Padding(
                                                padding: EdgeInsets.symmetric(vertical:10, horizontal: 10),
                                                child: Text('choose department :', style: TextStyle(color: Colors.white60,
                                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                      ),),
                                              ),
                                              
                                                Padding(
                                                padding:const EdgeInsets.symmetric(vertical:5),
                                                child: Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                         borderRadius: BorderRadius.circular(30),
                                                         ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal:14, vertical: 5),
                                                      child:  DropdownButtonHideUnderline(
                                                        child: DropdownButton<String>(
                                                            isExpanded: true,
                                                              borderRadius: BorderRadius.circular(35),
                                                              value: department,
                                                              icon: const Icon(Icons.keyboard_arrow_down,size: 35,color:  Color.fromARGB(255, 8, 61, 104),),
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
                                              ),
                                                   const Padding(
                                                padding: EdgeInsets.symmetric(vertical:10, horizontal: 10),
                                                child: Text('choose level :', style: TextStyle(color: Colors.white60,
                                                      fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                      ),),
                                              ),
                                                  Padding(
                                                    padding:const EdgeInsets.symmetric(vertical:5),
                                                    child: Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                             borderRadius: BorderRadius.circular(30),
                                                             ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal:14, vertical: 5),
                                                          child:  DropdownButtonHideUnderline(
                                                            child: DropdownButton<String>(
                                                                isExpanded: true,
                                                                  borderRadius: BorderRadius.circular(35),
                                                                  value: stage,
                                                                  icon:const Icon(Icons.keyboard_arrow_down,size: 35,color:  Color.fromARGB(255, 8, 61, 104),),
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
                                                  ),
                                              const Expanded(child: SizedBox(height: 5,))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                               )),
                      ),
                    )
              ],
        ),
           isLoading ? Center(
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
           ) : isFailed?
           Center(
           child: Container(
              height: 80,
              width: 80,
                      child:  showError()
                    ),
           ):
            Container()
            ],
          ),))
    );
  }
}
Widget showDone(){
return Container(
  decoration: BoxDecoration(shape: BoxShape.circle,
  color: Colors.green),
child: Icon(Icons.done, size: 60 , color: Colors.white,)
);
}
Widget showError(){
return Container(
  decoration: BoxDecoration(shape: BoxShape.circle,
  color: Colors.red),
child: Icon(Icons.close, size: 60 , color: Colors.white,)
);
}
