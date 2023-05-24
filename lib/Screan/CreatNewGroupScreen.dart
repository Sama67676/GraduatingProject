import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
  List<Map<String, dynamic>> memberList =[];
   bool isLoading= false;
bool isDone= false;
bool isFailed = false;
  final TextEditingController _search=TextEditingController();
  final TextEditingController _groupname=TextEditingController();

    List groupList=[];
FirebaseFirestore firestore = FirebaseFirestore.instance;

class CreatNewGroupScreen extends StatefulWidget {
  const CreatNewGroupScreen({super.key});

  @override
  State<CreatNewGroupScreen> createState() => _CreatNewGroupScreenState();
}

class _CreatNewGroupScreenState extends State<CreatNewGroupScreen> {

   XFile? photo;

   void createGroup(context, groupImage)async{
  setState(() {
    isLoading = true;
  });
  var uuid = const Uuid();

   
  
  String groupId= uuid.v1();
  await firestore.collection('groups').doc(groupId).set({
  'members':memberList,
  'groupsId':groupId,
   'groupName': _groupname.text,
   'groupImage':groupImage 
  });
  for (int i=0; i<memberList.length; i++){
    String uid= memberList[i]['uid'];
    await firestore.collection('users').doc(uid).collection('groups').doc(groupId).set({
      'groupName': _groupname.text,
      'groupId': groupId,
      'groupImage':groupImage 
    });
  }
  setState(() {
    isLoading = false;
    isDone = true;
  });
 

}

 void pickImage() async {
    photo = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);
    uploadpfp();
  }

  Future<void> uploadpfp() async {
    File? imagefile = File(photo!.path);
    try {
      Reference ref = FirebaseStorage.instance.ref('files/${imagefile.path}');
      UploadTask uploadTask = ref.putFile(imagefile);
      final snapshot = await uploadTask.whenComplete(() => null);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getDowmload() async {
    File? imagefile = File(photo!.path);
    return firebase_storage.FirebaseStorage.instance
        .ref('files/${imagefile.path}')
        .getDownloadURL();
  }


void initializeApp(){
  super.initState();

  }
  List <Map<String, dynamic>>? userMap=[];
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
          child: Stack(
            children: [
              Column(

                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:  [
                    
                      Expanded(
                        flex: 0,
                        child: Padding(
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
                                child: Expanded(flex:2, child: Text('Create Group',style:TextStyle(fontSize: 25, color: Color.fromARGB(255, 8, 61, 104)))),
                              ),
                               Expanded(
                                flex: 0,
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(horizontal:10),
                                   child: GestureDetector(child: const Text('Done',style:TextStyle(fontSize: 20, color: Color.fromARGB(255, 8, 61, 104))),
                          onTap: ()async{
                               await uploadpfp().then((value) => {});
                                                String value = await getDowmload();
                            createGroup(context,   value != null ? value : "",);},
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
                              child: Column(
                  
                                children: [
                             const SizedBox(height: 20,),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
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
                                        horizontal: 15,
                                        vertical: 15,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  [
                                         InkWell(
                                           child: CircleAvatar(
                                                backgroundColor: const Color.fromARGB(255, 205, 206, 212),
                                                // ignore: sort_child_properties_last
                                                
                                              
                                              backgroundImage: photo != null 
                                              ? FileImage(File(photo!.path))
                                  : null,
                              child: photo == null
                                  ? const Icon(
                                      Icons.camera_alt,
                                      size: 35,
                                      color: Colors.white,
                                    )
                                  : null),
                                              onTap: () {
                                                pickImage();
                                              
                                            
                                              },
                                         ),
                                             Padding(
                                              padding:const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 120,
                                                height: 60,
                                                child: TextField(
                                                  controller: _groupname,
                                                  decoration: const InputDecoration(hintText: 'Group name'),
                                                ),
                                              )
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                             ),
                            
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
                 isLoading ? const Center(
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
  
  const StudentLine({this.userName, this.uid, super.key, this.imageUrl});
  final String? userName;
  final String? uid;
  final String? imageUrl;

  @override
  State<StudentLine> createState() => _StudentLineState(userName, uid, imageUrl);
}

class _StudentLineState extends State<StudentLine> {
   bool isChecked = false;
  final String? userName;
  final String? uid;
  final String? imageUrl;

  _StudentLineState(this.userName, this.uid, this.imageUrl);

     
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
                                },
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



 Widget showDone(){
return Container(
  decoration: const BoxDecoration(shape: BoxShape.circle,
  color: Colors.green),
child: const Icon(Icons.done, size: 60 , color: Colors.white,)
);
}
Widget showError(){
return Container(
  decoration: const BoxDecoration(shape: BoxShape.circle,
  color: Colors.red),
child: const Icon(Icons.close, size: 60 , color: Colors.white,)
);
}
