import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import '../Others/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../Others/auth.dart';
import '../Others/fireBase_Storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileScreen extends StatefulWidget {
  static const String ScreanRoute = 'profile_Screen';
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  Authintication _authintication = Authintication();

  String? Name;

  String? email;

  String? department;

  String? status;

  String? year;

  String? imageUrl;

  Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          Name = snapshot.data()!['Name'];
          department = snapshot.data()!['department'];
          status = snapshot.data()!['status'];
          year = snapshot.data()!['year'];
          email = snapshot.data()!['email'];
          imageUrl = snapshot.data()!['imgUrl'];
        });
      }
    });
    
  }

  Future getCurrentUserId() async {
    return await FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final FireBaseStorage storage = FireBaseStorage();
    return SafeArea(
      child: Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: 
            Column(
              

              children: [
                
                Row(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Color.fromARGB(255, 8, 61, 104)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: IconButton(
                    //     icon: const Icon(Icons.edit,
                    //         color: Color.fromARGB(255, 8, 61, 104)),
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
                ),
                        
                            InkWell(
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: imageUrl != null
                                          ? NetworkImage(imageUrl!)
                                          : null,
                                      child: imageUrl == null
                                          ? Icon(
                                              Icons.person,
                                              size: 60,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                    onTap: () {
                                      changeProfile(context, imageUrl);
                                      setState(() { });
                                    }
                                    ),
                       
                   Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Name != null?
                          Text(
                            '$Name',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                               fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                fontSize: 30, color: Colors.indigo[900]),
                          ):
                          Container(height: 1, width: 1,)
                        ),
                   Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child:department != null? 
                          Text(
                            '$department' + ' ' + '$year' + ' ' + 'year',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                               fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                fontSize: 30, color: Colors.indigo[900]),
                          ):
                                Container(height: 1, width: 1,)
                        ),
                         Expanded(
                           child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),),
                            elevation: 0,
                            color: const Color.fromARGB(255, 8, 61, 104),
                            child:Padding(
                            padding: const EdgeInsets.all(18),
                            child: status != null?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                             InkWell(
                                child:  Material(
                              color: Colors.white,
                              elevation: 1, //shadows
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Padding(
                                padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 2),
                                child: Text(
                                  'bio',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                     fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                      fontSize: 20, color: Colors.indigo[900]),
                                ),
                              ),
                                    Padding(
                                     padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                      child: 
                                      Text('$status',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                             fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                              fontSize: 20, color: Colors.indigo[900])),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                                                 
                                                 onTap: () {
                            ChangeBio(context);
                            setState(() {});
                                                 },
                                               ),
                                                ],
                                               ):
                                              Center(
             child: SizedBox(
                  height: 60,
                  width: 60,
                          child:  CircularProgressIndicator(
                          color: Colors.black38,
                           strokeWidth: 4,
                          ),
                        ),
         
             
           ) 
                                                )),
                         ),
                      
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 120,
                        child: Material(
                          color: Colors.indigo[800],
                          borderRadius: BorderRadius.circular(45),
                          child: MaterialButton(
                            onPressed: () {
                              AuthNotifier authNotifier =
                                  Provider.of<AuthNotifier>(context, listen: false);
                              
                                _authintication.signout(authNotifier, context);
                              
                            },
                            child: Row(
                              children: const [
                                 Padding(
                                  padding:  EdgeInsets.all(10),
                                  child:  Text(
                                    'Log out',
                                    style: TextStyle(
                                       fontFamily: 'HP Simplified Light', fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ),
                               Icon(Icons.logout,
                                                  color: Colors.white,
                                                  size: 20,),
                              ],
                            ),
                          ),
                        ),
                      ),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
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


Future<void> changeProfile(context, imageUrl) async{

       return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        actionsPadding: const EdgeInsets.only(left:20, right: 20, bottom: 20),
       shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35))),
       title: const Text('Change your profile picture', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                 fontSize: 20,),),
        content:
            InkWell(child: CircleAvatar(radius: 40,
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
            
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                 fontSize: 18),),
            onPressed: () {
             
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                fontSize: 18),),
            onPressed: () async {
              if( imageUrl== null){
             
               await uploadpfp().then((value) => {});
              String? value = await getDowmload();
              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
              
                'imgUrl': value,
              });
              }else{
                

                await uploadpfp().then((value) => {});
              String? value = await getDowmload();
              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
              
                'imgUrl': value,
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
  Future<void> ChangeBio(context) async{
  final TextEditingController NewName = TextEditingController();
       return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        actionsPadding: const EdgeInsets.only(left:20, right: 20, bottom: 20),
       shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35))),
       title: const Text('Change your Bio', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                 fontSize: 20,),),
        content:  Container(
              width: 80,
              height: 40,
              child: TextField(controller: NewName,
               decoration: const InputDecoration(hintText: 'New name'),
              ),
            ),
            
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                 fontSize: 18),),
            onPressed: () {
             
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Approve', style: TextStyle( color: Color.fromARGB(255, 8, 61, 104),
                                                fontSize: 18),),
            onPressed: () async {
              
              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
              
                'status': NewName.text,
              });
              
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }
  