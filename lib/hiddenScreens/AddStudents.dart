import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final TextEditingController _search=TextEditingController();
   
   
List<Map<String, dynamic>> memberList =[];

class AddStudents extends StatefulWidget {
  const AddStudents({super.key,});


  @override
  State<AddStudents> createState() => _AddStudentssState();
}

class _AddStudentssState extends State<AddStudents> {


  @override
   Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    child: Column(
                      children: [
                          SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10),
                          child: GestureDetector(child: const Text('Cancel',style:TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 61, 104))),
                          onTap: (){
                            Navigator.pop(context);
                          },
                          ),
                        ),
                      ],
                    ),
                  ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal:20),
                            child: Expanded(flex:2, child: Text('Add Members',style:TextStyle(fontSize: 25, color: Color.fromARGB(255, 8, 61, 104)))),
                          ),
                           Expanded(
                            flex: 0,
                             child: Column(
                               children: [
                                  SizedBox(height: 30,),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal:10),
                                   child: GestureDetector(child: const Text('Done',style:TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 61, 104))),
                      onTap: (){
                        Navigator.pop(context, memberList);
                      }
                      ),
                                 ),
                               ],
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
                          child: Column(
              
                            children: [
                         
                        
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 18),
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
                                  vertical: 12,
                                ),
                                child: TextField(controller: _search,
                                decoration: const InputDecoration(hintText: 'Who would you like to add',
                                suffixIcon:  Icon(
                                  Icons.search,
                                  color:  Color.fromARGB(255, 8, 61, 104),
                                  size: 40,
                                ),
                                  ),
                                  )
                                  ),
                                ),
                                    ),
                              const StudentStreamBuilder()
                              ],
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

class StudentStreamBuilder extends StatelessWidget {
  const StudentStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            
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
                  memberList: memberList,
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

class StudentLine extends StatefulWidget {
  
  const StudentLine({this.userName, this.uid, super.key, this.imageUrl, required this.memberList});
  final String? userName;
  final String? uid;
  final String? imageUrl;
  final List <Map<String, dynamic>> memberList;

  @override
  State<StudentLine> createState() => _StudentLineState(userName, uid, imageUrl, memberList);
}

class _StudentLineState extends State<StudentLine> {
   bool isChecked = false;
  final String? userName;
  final String? uid;
  final String? imageUrl;
  final List <Map<String, dynamic>> memberList;
  _StudentLineState(this.userName, this.uid, this.imageUrl, this.memberList);

     
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 10.5,
                   backgroundColor: const Color.fromARGB(255, 205, 206, 212),
                  child:  Transform.scale(
                     scale: 1.3,
                    child: Checkbox(
                    activeColor:const Color.fromARGB(255, 8, 61, 104) ,
                                value:isChecked,
                                shape: const CircleBorder(),
                                onChanged: (value) {
                                  setState(() {
                                      isChecked = value!;

                                  });
                                 if(value==true){
                                    memberList.add({'name':userName,
                                   'uid':uid,});
                                  } else if(value==false){
                                    memberList.remove({'name':userName,
                                    'uid':uid,});
                                  }
                                }
                              ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.imageUrl!),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 180,
                  child: Text(
                    '${widget.userName}',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ]),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
