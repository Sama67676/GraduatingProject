// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:graduating_project_transformed/Screan/Chat_screan.dart';
import 'package:image_picker/image_picker.dart';


import '../main.dart';
import 'AddPeople.dart';
 
 int? numberOfMembers;
  List  membersList = [];
var items =['remove member', 'idk'];
 FirebaseFirestore _firestore = FirebaseFirestore.instance;
   FirebaseAuth _auth = FirebaseAuth.instance;
class GroupProfile extends StatefulWidget {
  const GroupProfile({super.key,  this.groupImage,  required this.groupName, required this.groupId});
  final String? groupImage;
  final String groupName;
  final String groupId;

  @override
  State<GroupProfile> createState() => _GroupProfileState(groupImage, groupName, groupId);
}

class _GroupProfileState extends State<GroupProfile> {
final String? groupImage;
  final String groupName;
  final String groupId;
  
    
   _GroupProfileState(this.groupImage, this.groupName, this.groupId);

  Future getGroupDetails() async {
    await _firestore
        .collection('groups')
        .doc(groupId)
        .get()
        .then((chatMap) {
      membersList = chatMap['members'];
      numberOfMembers =membersList.length;
      setState(() {
        
      });
      print(membersList);
      print(membersList.length);
    });
  }


  
  @override
  void initState() {
    super.initState();
    getGroupDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                  Expanded(
                    flex: 1,
                    child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Color.fromARGB(255, 8, 61, 104)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                  ),
                      const Expanded(
                        flex: 4,
                        child: SizedBox(width: 30,)),
                    Expanded(
                      flex: 1,
                      child: PopupMenuButton(
                        icon: const Icon(Icons.edit,
                            color: Color.fromARGB(255, 8, 61, 104)),
                             itemBuilder: (context) => [ const PopupMenuItem(
           child: Text('Edit group Details', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104), fontSize: 20),), value: '1'),
        const PopupMenuItem<String>(
            child: Text('Leave Group', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104), fontSize: 20),), value: '2'),
        const PopupMenuItem<String>(
            child: Text('Delete group', style: TextStyle(color: Color.fromARGB(255, 8, 61, 104), fontSize: 20),), value: '3'),
      ],
                         elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
               Radius.circular(35),
          ),
),
onSelected: (result) {
  if (result == '1'){
    changeGroupDetails(context, groupId);
  }
    if (result == '2') {
      AlertLeavingGroup( context, groupId,);
     
    } else if(result == '3'){
      AlertDeletingGroup(context, groupId);
    }
},
                      ),
                    ),
                  ],
                ),
       
             Padding(
               padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
               child: Row(
                children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundImage: widget.groupImage != null?
                      NetworkImage(widget.groupImage!): null),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(widget.groupName, style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 8, 61, 104)),),
                      ),
              
                ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
               child: Text(
                '$numberOfMembers Members',
                style:  const TextStyle(fontSize: 22, color: Color.fromARGB(255, 8, 61, 104))),
             ),
              
              Expanded(
                  flex: 6,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                      color: const Color.fromARGB(255, 8, 61, 104),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                              onTap: () {
                                 Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex) => AddMembers(groupId: groupId, groupImage: groupImage, groupName: groupName, memberList: membersList,)));
            setState(() {
              
            });
            },

                              leading: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                              title: const Text(
                                "Add Members",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                               ),
                            ),
                           Flexible(
                      child: ListView.builder(
                        itemCount: membersList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () =>showRemoveMemberDialog(index,context, groupId),
                            
                            leading: const Icon(Icons.account_circle, color: Colors.white60,),
                            title: Text(
                              membersList[index]['name'],
                              style: const TextStyle(
                                fontSize:  22,
                                color: Colors.white60,
                               
                              ),
                            ),
                           
                            // trailing: Text(
                            //     membersList[index]['isAdmin'] ? "Admin" : ""),
                          );
                          
                        },
                      ),
                    ),
                          ],
                        ),
                      )),
                ),
            ],
          ),
        )),
      ),
    );
  }
}

  Future removeMembers(int index, String groupId ) async {
    String uid = membersList[index]['uid'];
    print(uid);

      membersList.removeAt(index);
      print(membersList);
      

   
    await _firestore.collection('groups').doc(groupId).update({
      "members": membersList,}
    ).then((value) async {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('groups')
          .doc(groupId)
          .delete();
    }).catchError((e){print(e);});
  }
  void showRemoveMemberDialog(int index,context, groupId) {
    
      // if (_auth.currentUser!.uid != membersList[index]['uid']) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: ListTile(
                  onTap: () { removeMembers(index, groupId);
                  Navigator.pop(context);
                  },
                  title: const Text("KICK OUT THIS MEMBER"),
                ),
              );
            });
      
    
  }

Future onLeaveGroup(groupId, context) async {
      for (int i = 0; i < membersList.length; i++) {
        if (membersList[i]['uid'] == _auth.currentUser!.uid) {
          membersList.removeAt(i);
        }
      }

      await _firestore.collection('groups').doc(groupId).update({
        "members": membersList,
      });

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('groups')
          .doc(groupId)
          .delete();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ButtomNavigationBar()),
        (route) => false,
      );
    
  }
  
  Future onDeleteGroup(String groupId,context)async{
    await firestore.collection('groups').doc(groupId).delete();
    print('group deleted');
    for (int i=0; i<=membersList.length; i++){
    String memberId = membersList[i]['uid'];
      await firestore.collection('users').doc(memberId).collection('groups').doc(groupId).delete();
    }
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ButtomNavigationBar()),
        (route) => false,
      );
  }

Future<void> AlertLeavingGroup(context,groupId) async{
       return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(30),
        actionsPadding: const EdgeInsets.only(left:20, right: 20, bottom: 20),
       shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35))),
       
        content:Text('Are you sure you want to leave this group?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
             
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
               
               onLeaveGroup(groupId, context);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }
  
Future<void> AlertDeletingGroup(context,groupId) async{
       return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(30),
        actionsPadding: const EdgeInsets.only(left:20, right: 20, bottom: 20),
       shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35))),
       
        content:Text('Are you sure you want to delete this group?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
             
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              onDeleteGroup(groupId, context);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }


Future<void> changeGroupDetails(context,groupId) async{
  final TextEditingController NewName = TextEditingController();
       return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(30),
        actionsPadding: const EdgeInsets.only(left:20, right: 20, bottom: 20),
       shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35))),
       
        content: Row(
          children: [
            InkWell(child: CircleAvatar(radius: 20,
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
            SizedBox(width: 10,),
            Container(
              width: 120,
              height: 60,
              child: TextField(controller: NewName,
               decoration: InputDecoration(hintText: 'New name'),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
             
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve'),
            onPressed: () async {
               await uploadpfp().then((value) => {});
              String? value = await getDowmload();
              await firestore.collection('groups').doc(groupId).update({
                'groupName':NewName.text,
                'groupImage': value,
              });
              for(int i=0; i<=membersList.length; i++){
                 String memberId = membersList[i]['uid'];
      await firestore.collection('users').doc(memberId).collection('groups').doc(groupId).update({
        'groupImage': value,
        'groupName': NewName.text
      });
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }

  
   XFile? photo;

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





  